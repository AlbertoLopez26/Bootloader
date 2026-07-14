#!/usr/bin/env python3
"""
========================================================================
 XBee Bootloader Host - PIC18F47Q43 / MDFU-FTP via XBee API Mode
========================================================================
 Descripción:
   Script host para cargar firmware en un PIC18F47Q43 a través de dos
   módulos XBee en modo API (AP=1). Implementa el protocolo MDFU-FTP
   (Microchip Device Firmware Upgrade - File Transfer Protocol).

 Uso:
   python xbee_bootloader_host.py --port COM3 --hex firmware.hex [opciones]

 Dependencias:
   pip install pyserial intelhex

 Configuración del PIC18F47Q43:
   - App start: 0x003000
   - App end:   0x01FFFF
   - Page size: 256 bytes
   - Device ID: 0x000074A0
   - CRC-16 (polinomio 0x1021, semilla 0xFFFF)
   - Unlock key: 0xAA55

 Configuración XBee:
   - AP = 1  (API Mode Without Escapes)
   - BD = 7  (115200 bps)
   - Mismo PAN ID en ambos módulos
========================================================================
"""

import argparse
import struct
import sys
import time
import logging
import os
from enum import IntEnum

try:
    import serial
except ImportError:
    print("[ERROR] pyserial no encontrado. Instalar con: pip install pyserial")
    sys.exit(1)

try:
    from intelhex import IntelHex
except ImportError:
    print("[ERROR] intelhex no encontrado. Instalar con: pip install intelhex")
    sys.exit(1)


# ===========================================================================
#  CONFIGURACIÓN DEL DISPOSITIVO (extraída de bootloader_configuration.toml)
# ===========================================================================
DEVICE_ID           = 0x000074A0   # PIC18F47Q43
APP_START_ADDRESS   = 0x3000       # Flash de aplicación
APP_END_ADDRESS     = 0x1FFFF      # Último byte de la aplicación
PAGE_SIZE           = 256          # PROGMEM_PAGE_SIZE
EEPROM_START        = 0x380000     # Dirección base EEPROM/DFM

# Claves de desbloqueo NVM del PIC18F47Q43
PAGE_ERASE_KEY  = 0xAA55
PAGE_WRITE_KEY  = 0xAA55
BYTE_WRITE_KEY  = 0xAA55
PAGE_READ_KEY   = 0x0000           # No utilizada (0x0000)

# Versión del formato de imagen esperada por el bootloader (de bl_config.h)
IMAGE_FORMAT_MAJOR  = 0x00
IMAGE_FORMAT_MINOR  = 0x03
IMAGE_FORMAT_PATCH  = 0x00

# CRC-16/CCITT-FALSE (polinomio 0x1021, semilla 0xFFFF)
CRC16_POLY  = 0x1021
CRC16_SEED  = 0xFFFF
HASH_DATA_SIZE = 2                 # Tamaño del CRC en bytes al final de la app

# ===========================================================================
#  PROTOCOLO XBee API
# ===========================================================================
XBEE_START_DELIMITER    = 0x7E
XBEE_TX_FRAME_TYPE      = 0x10    # Transmit Request
XBEE_RX_FRAME_TYPE      = 0x90    # Receive Packet
XBEE_TX_STATUS_TYPE     = 0x8B    # Tx Status (esperado si no usamos frameID=0)

# Dirección broadcast XBee (opcional para descubrimiento de dispositivos)
XBEE_BROADCAST_ADDR_64  = b'\x00\x00\x00\x00\x00\x00\xFF\xFF'
XBEE_BROADCAST_ADDR_16  = b'\xFF\xFE'

# ===========================================================================
#  PROTOCOLO FTP / MDFU
# ===========================================================================
# Comandos FTP
class FTPCommand(IntEnum):
    GET_CLIENT_INFO = 0x01
    START_TRANSFER  = 0x02
    WRITE_CHUNK     = 0x03
    GET_IMAGE_STATE = 0x04
    END_TRANSFER    = 0x05

# Respuestas FTP
class FTPStatus(IntEnum):
    COMMAND_SUCCESS       = 0x01
    COMMAND_NOT_SUPPORTED = 0x02
    COMMAND_NOT_AUTHORIZED= 0x03
    COMMAND_NOT_EXECUTED  = 0x04
    ABORT_TRANSFER        = 0x05

# Bits del byte de secuencia
SEQ_RETRY_BIT   = 0x40
SEQ_SYNC_BIT    = 0x80
SEQ_NUMBER_MASK = 0x3F
MAX_SEQUENCE    = 31

# Tipos de bloque para FTP_WRITE_CHUNK
class BlockType(IntEnum):
    UNLOCK_BOOTLOADER = 0x01
    WRITE_FLASH       = 0x02

# Timeout y reintentos
DEFAULT_TIMEOUT_S   = 10.0     # Timeout por respuesta del PIC
MAX_RETRIES         = 5        # Reintentos máximos por paquete
INTER_MSG_DELAY_S   = 0.0015  # 1.5 ms entre mensajes (requerido por el bootloader)


# ===========================================================================
#  UTILIDADES
# ===========================================================================

def crc16_calculate(data: bytes, seed: int = CRC16_SEED) -> int:
    """CRC-16/CCITT-FALSE: polinomio 0x1021, sin inversión de bits."""
    crc = seed
    for byte in data:
        crc ^= (byte << 8)
        for _ in range(8):
            if crc & 0x8000:
                crc = ((crc << 1) ^ CRC16_POLY) & 0xFFFF
            else:
                crc = (crc << 1) & 0xFFFF
    return crc


def crc16_bytes(data: bytes) -> bytes:
    """Devuelve el CRC-16 como 2 bytes en little-endian."""
    crc = crc16_calculate(data)
    return struct.pack('<H', crc)


# ===========================================================================
#  CAPA XBEE API
# ===========================================================================

class XBeeAPI:
    """
    Maneja la comunicación en modo API (AP=1) con el módulo XBee local.
    Encapsula y desencapsula tramas XBee API Frame 0x10 / 0x90.
    """

    def __init__(self, port: str, baudrate: int = 115200, timeout: float = DEFAULT_TIMEOUT_S):
        self.log = logging.getLogger("XBeeAPI")
        try:
            self.ser = serial.Serial(port, baudrate=baudrate, timeout=0.05)
        except serial.SerialException as e:
            raise RuntimeError(f"No se pudo abrir el puerto {port}: {e}")
        self.timeout = timeout
        self.dest_mac  = None   # Dirección MAC de 64 bits del XBee remoto
        self.dest_16   = b'\xFF\xFE'  # Dirección 16-bit del XBee remoto
        self.log.info(f"Puerto {port} abierto a {baudrate} bps")

    def close(self):
        if self.ser.is_open:
            self.ser.close()

    def _calc_checksum(self, frame_data: bytes) -> int:
        """Calcula el checksum XBee: 0xFF - (suma de bytes de datos & 0xFF)."""
        return (0xFF - (sum(frame_data) & 0xFF)) & 0xFF

    def build_tx_frame(self, payload: bytes) -> bytes:
        """
        Construye una trama XBee API Transmit Request (0x10).
        FrameID = 0x00 para deshabilitar la respuesta Tx Status.
        """
        if self.dest_mac is None:
            raise RuntimeError("Dirección MAC del destinatario no configurada.")

        frame_data = bytes([XBEE_TX_FRAME_TYPE, 0x00])  # Type + FrameID=0 (sin Tx Status)
        frame_data += self.dest_mac                       # Dirección 64-bit
        frame_data += self.dest_16                        # Dirección 16-bit
        frame_data += bytes([0x00, 0x00])                 # Broadcast radius + Options
        frame_data += payload

        length = len(frame_data)
        checksum = self._calc_checksum(frame_data)

        frame = bytes([XBEE_START_DELIMITER])
        frame += struct.pack('>H', length)
        frame += frame_data
        frame += bytes([checksum])
        return frame

    def send(self, payload: bytes):
        """Envía un payload FTP encapsulado en una trama XBee."""
        frame = self.build_tx_frame(payload)
        self.log.debug(f"TX [{len(frame)} bytes]: {frame.hex(' ').upper()}")
        self.ser.write(frame)

    def receive(self, timeout: float = None) -> bytes | None:
        """
        Espera y recibe una trama XBee API tipo 0x90 (Receive Packet).
        Devuelve solo el payload de la aplicación (datos FTP).
        Descarta silenciosamente Tx Status (0x8B) y otros tipos de tramas.
        Retorna None si se agota el timeout.
        """
        deadline = time.time() + (timeout or self.timeout)

        while time.time() < deadline:
            # Esperar inicio de trama
            byte = self.ser.read(1)
            if not byte or byte[0] != XBEE_START_DELIMITER:
                continue

            # Leer longitud
            len_bytes = self.ser.read(2)
            if len(len_bytes) < 2:
                continue
            frame_len = struct.unpack('>H', len_bytes)[0]

            # Leer datos + checksum
            frame_data_raw = self.ser.read(frame_len + 1)
            if len(frame_data_raw) < frame_len + 1:
                self.log.warning("Trama incompleta recibida")
                continue

            frame_data = frame_data_raw[:frame_len]
            checksum   = frame_data_raw[frame_len]

            # Verificar checksum
            if ((sum(frame_data) + checksum) & 0xFF) != 0xFF:
                self.log.warning(f"Checksum inválido en trama recibida (tipo={frame_data[0]:02X})")
                continue

            frame_type = frame_data[0]
            self.log.debug(f"RX frame tipo=0x{frame_type:02X} [{frame_len} bytes]: {frame_data.hex(' ').upper()}")

            if frame_type == XBEE_RX_FRAME_TYPE:
                # Trama 0x90: 1(tipo) + 8(MAC64) + 2(Addr16) + 1(opciones) = 12 bytes de cabecera
                if frame_len < 12:
                    self.log.warning("Trama RX demasiado corta")
                    continue

                # Capturar la dirección del remitente para futuras respuestas
                sender_mac  = frame_data[1:9]
                sender_16   = frame_data[9:11]
                if self.dest_mac is None:
                    self.dest_mac = sender_mac
                    self.dest_16  = sender_16
                    self.log.info(f"Dirección remota aprendida: {sender_mac.hex(':').upper()}")

                payload = frame_data[12:]
                self.log.debug(f"Payload FTP [{len(payload)} bytes]: {payload.hex(' ').upper()}")
                return payload

            elif frame_type == XBEE_TX_STATUS_TYPE:
                # Descartamos Tx Status silenciosamente (no debería llegar con FrameID=0)
                self.log.debug("Trama Tx Status recibida y descartada")
                continue
            else:
                self.log.debug(f"Tipo de trama desconocido 0x{frame_type:02X}, descartado")
                continue

        return None  # Timeout


# ===========================================================================
#  CAPA FTP / MDFU
# ===========================================================================

class MDFUClient:
    """
    Implementa el protocolo MDFU-FTP para comunicarse con el bootloader del PIC18.
    Maneja el número de secuencia y el CRC-16 de trama.
    """

    def __init__(self, xbee: XBeeAPI):
        self.xbee = xbee
        self.log  = logging.getLogger("MDFUClient")
        self.seq_num = 0     # Número de secuencia actual (0-31)

    def _build_ftp_frame(self, command: int, data: bytes = b'') -> bytes:
        """
        Construye una trama FTP completa:
          [SEQ_BYTE][CMD_BYTE][DATA...][CRC16_LE (2 bytes)]
        """
        seq_byte = self.seq_num & SEQ_NUMBER_MASK
        body = bytes([seq_byte, command]) + data
        crc  = crc16_bytes(body)
        return body + crc

    def _next_seq(self):
        """Avanza el número de secuencia (0-31, circular)."""
        self.seq_num = (self.seq_num + 1) % (MAX_SEQUENCE + 1)
        if self.seq_num == 0:
            self.seq_num = 1  # Evitar 0 después del inicio

    def _send_and_receive(self, command: int, data: bytes = b'',
                          timeout: float = DEFAULT_TIMEOUT_S) -> tuple[bool, bytes]:
        """
        Envía un comando FTP y espera la respuesta con reintentos automáticos.
        Retorna (éxito, payload_de_respuesta).
        """
        ftp_frame = self._build_ftp_frame(command, data)
        self.log.debug(f"FTP TX -> CMD=0x{command:02X} SEQ={self.seq_num} [{len(ftp_frame)} bytes]")

        for attempt in range(MAX_RETRIES):
            self.xbee.send(ftp_frame)
            time.sleep(INTER_MSG_DELAY_S)

            response = self.xbee.receive(timeout=timeout)
            if response is None:
                self.log.warning(f"Timeout esperando respuesta (intento {attempt+1}/{MAX_RETRIES})")
                continue

            if len(response) < 4:
                self.log.warning(f"Respuesta demasiado corta ({len(response)} bytes)")
                continue

            # Verificar CRC de la respuesta
            resp_body = response[:-2]
            resp_crc  = response[-2:]
            expected_crc = crc16_bytes(resp_body)
            if resp_crc != expected_crc:
                self.log.warning(f"CRC de respuesta inválido: got={resp_crc.hex()} expected={expected_crc.hex()}")
                continue

            resp_seq    = resp_body[0] & SEQ_NUMBER_MASK
            resp_status = resp_body[1]
            resp_data   = resp_body[2:]

            # Verificar que la respuesta corresponde a nuestro número de secuencia
            if resp_seq != (self.seq_num & SEQ_NUMBER_MASK):
                retry_bit = (resp_body[0] & SEQ_RETRY_BIT) != 0
                if retry_bit:
                    self.log.warning(f"Bootloader solicita reenvío (SEQ esperado={self.seq_num}, recibido={resp_seq})")
                    continue
                else:
                    self.log.warning(f"Número de secuencia inesperado en respuesta: got={resp_seq} expected={self.seq_num}")
                    continue

            if resp_status == FTPStatus.COMMAND_SUCCESS:
                self._next_seq()
                return True, resp_data
            elif resp_status == FTPStatus.ABORT_TRANSFER:
                abort_code = resp_data[0] if resp_data else 0xFF
                self.log.error(f"Bootloader abortó la transferencia. Código: 0x{abort_code:02X}")
                return False, resp_data
            else:
                self.log.warning(f"Estado de respuesta inesperado: 0x{resp_status:02X}")
                continue

        self.log.error(f"Agotados {MAX_RETRIES} intentos para CMD=0x{command:02X}")
        return False, b''

    def get_client_info(self) -> dict | None:
        """
        Paso 1 del protocolo MDFU:
        Solicita información del bootloader (versión, tamaño de bloque, timeout).
        """
        self.log.info(">>> GET CLIENT INFO")
        ok, data = self._send_and_receive(FTPCommand.GET_CLIENT_INFO)
        if not ok:
            return None

        # Parsear TLVs de la respuesta
        info = {}
        i = 0
        while i + 2 <= len(data):
            tlv_type   = data[i]
            tlv_length = data[i+1]
            tlv_value  = data[i+2: i+2+tlv_length]
            i += 2 + tlv_length

            if tlv_type == 0x01 and len(tlv_value) >= 3:  # FTP_PROTOCOL_VERSION
                info['ftp_version'] = f"{tlv_value[0]}.{tlv_value[1]}.{tlv_value[2]}"
                self.log.info(f"    Versión FTP: {info['ftp_version']}")
            elif tlv_type == 0x02 and len(tlv_value) >= 3:  # FTP_TRANSFER_PARAMETERS
                info['max_payload'] = struct.unpack('<H', tlv_value[0:2])[0]
                info['num_buffers'] = tlv_value[2]
                self.log.info(f"    Max payload: {info['max_payload']} bytes | Buffers: {info['num_buffers']}")
            elif tlv_type == 0x03 and len(tlv_value) >= 3:  # FTP_TIMEOUT_INFO
                timeout_val = struct.unpack('<H', tlv_value[1:3])[0]
                info['cmd_timeout_s'] = timeout_val / 10.0
                self.log.info(f"    Timeout: {info['cmd_timeout_s']} s")
            elif tlv_type == 0x04 and len(tlv_value) >= 4:  # FTP_MIN_INTER_MESSAGE_DELAY
                delay_ns = struct.unpack('<I', tlv_value[0:4])[0]
                info['inter_msg_delay_ms'] = delay_ns / 1_000_000
                self.log.info(f"    Min inter-msg delay: {info['inter_msg_delay_ms']:.2f} ms")

        return info

    def start_transfer(self) -> bool:
        """
        Paso 2 del protocolo MDFU:
        Notifica al bootloader que va a comenzar la transferencia.
        También le indica que borre la zona de aplicación.
        """
        self.log.info(">>> START TRANSFER")
        ok, _ = self._send_and_receive(FTPCommand.START_TRANSFER,
                                       timeout=DEFAULT_TIMEOUT_S * 3)  # Borrado puede tardar
        if ok:
            self.log.info("    Área de aplicación borrada correctamente")
        return ok

    def write_chunk(self, chunk_data: bytes, timeout: float = DEFAULT_TIMEOUT_S) -> bool:
        """
        Paso 3 del protocolo MDFU:
        Envía un bloque de datos (FTP_WRITE_CHUNK).
        """
        ok, _ = self._send_and_receive(FTPCommand.WRITE_CHUNK, chunk_data, timeout=timeout)
        return ok

    def get_image_state(self) -> bool:
        """
        Paso 4 del protocolo MDFU:
        Solicita la verificación del CRC de la imagen cargada.
        Retorna True si la imagen es válida.
        """
        self.log.info(">>> GET IMAGE STATE (verificando CRC...)")
        ok, data = self._send_and_receive(FTPCommand.GET_IMAGE_STATE,
                                          timeout=DEFAULT_TIMEOUT_S * 5)
        if not ok:
            return False
        if data:
            state = data[0]
            is_valid = (state == 0x01)  # FTP_IMAGE_VALID
            self.log.info(f"    Estado imagen: {'VÁLIDA ✓' if is_valid else 'INVÁLIDA ✗'} (0x{state:02X})")
            return is_valid
        return False

    def end_transfer(self) -> bool:
        """
        Paso 5 del protocolo MDFU:
        Indica el fin de la transferencia. El bootloader reiniciará en la nueva app.
        """
        self.log.info(">>> END TRANSFER (reiniciando PIC...)")
        ok, _ = self._send_and_receive(FTPCommand.END_TRANSFER,
                                       timeout=DEFAULT_TIMEOUT_S * 2)
        return ok


# ===========================================================================
#  PROCESADOR DE ARCHIVO .HEX → BLOQUES MDFU
# ===========================================================================

class HexProcessor:
    """
    Lee un archivo .hex de Intel y genera los bloques de datos para el protocolo MDFU.
    
    Estructura del bloque UNLOCK_BOOTLOADER:
      [blockLength:u16][blockType:u8][patch:u8][minor:u8][major:u8]
      [deviceId:u32][maxPayload:u16][startAddr:u32]
      [eraseKey:u16][writeKey:u16][byteWriteKey:u16][readKey:u16]

    Estructura del bloque WRITE_FLASH:
      [blockLength:u16][blockType:u8][startAddr:u32]
      [eraseKey:u16][writeKey:u16][byteWriteKey:u16][readKey:u16]
      [data: PAGE_SIZE bytes]
    """

    def __init__(self, hex_path: str):
        self.log = logging.getLogger("HexProcessor")
        self.ih  = IntelHex()
        try:
            self.ih.loadhex(hex_path)
        except Exception as e:
            raise ValueError(f"Error cargando el archivo .hex: {e}")
        self.log.info(f"Archivo .hex cargado: {hex_path}")

    def get_app_pages(self) -> list[tuple[int, bytes]]:
        """
        Extrae las páginas de flash del rango de la aplicación.
        Retorna una lista de (address, page_data) donde len(page_data) == PAGE_SIZE.
        Las direcciones que no están en el hex se rellenan con 0xFF.
        """
        pages = []

        # Calcular el rango que contiene datos de la app (excluyendo los últimos 2 bytes de CRC)
        app_data_end = APP_END_ADDRESS - HASH_DATA_SIZE  # Último byte antes del CRC

        # Iterar en bloques de PAGE_SIZE alineados
        addr = APP_START_ADDRESS
        while addr <= app_data_end:
            page_bytes = bytearray(PAGE_SIZE)
            has_data   = False

            for offset in range(PAGE_SIZE):
                real_addr = addr + offset
                if real_addr > app_data_end:
                    page_bytes[offset] = 0xFF
                    continue
                # IntelHex devuelve 0xFF para bytes no especificados
                byte_val = self.ih[real_addr]
                page_bytes[offset] = byte_val
                if byte_val != 0xFF:
                    has_data = True

            if has_data:
                pages.append((addr, bytes(page_bytes)))
                self.log.debug(f"  Página 0x{addr:06X}: {len(page_bytes)} bytes")

            addr += PAGE_SIZE

        self.log.info(f"Total páginas con datos: {len(pages)}")
        return pages

    def compute_crc16(self) -> int:
        """
        Calcula el CRC-16 sobre los bytes de la aplicación en el rango correcto,
        tal como lo hace el bootloader: desde APP_START_ADDRESS hasta HASH_STORE_ADDRESS-1.
        HASH_STORE_ADDRESS = APP_END_ADDRESS - HASH_DATA_SIZE + 1
        """
        hash_store_addr = APP_END_ADDRESS - HASH_DATA_SIZE + 1
        calc_length     = hash_store_addr - APP_START_ADDRESS

        data = bytearray()
        for addr in range(APP_START_ADDRESS, APP_START_ADDRESS + calc_length):
            data.append(self.ih[addr])

        crc = crc16_calculate(bytes(data))
        self.log.info(f"CRC-16 calculado: 0x{crc:04X}")
        return crc

    def build_unlock_block(self) -> bytes:
        """
        Construye el bloque UNLOCK_BOOTLOADER (blockType=0x01).

        Estructura bl_unlock_boot_metadata_t:
          bl_block_header_t  { blockLength: u16, blockType: u8 }
          imageVersionPatch  : u8
          imageVersionMinor  : u8
          imageVersionMajor  : u8
          deviceId           : u32
          maxPayloadSize     : u16
          bl_command_header_t {
            startAddress      : u32
            pageEraseUnlockKey: u16
            pageWriteUnlockKey: u16
            byteWriteUnlockKey: u16
            pageReadUnlockKey : u16
          }
        """
        # Tamaño total del bloque sin el blockLength mismo
        # blockLength incluye blockType + resto
        block_type  = BlockType.UNLOCK_BOOTLOADER

        # Construir el payload del bloque (sin blockLength)
        payload = struct.pack('<B', block_type)          # blockType (1 byte)
        payload += struct.pack('<B', IMAGE_FORMAT_PATCH) # patch
        payload += struct.pack('<B', IMAGE_FORMAT_MINOR) # minor
        payload += struct.pack('<B', IMAGE_FORMAT_MAJOR) # major
        payload += struct.pack('<I', DEVICE_ID)          # deviceId (4 bytes LE)
        payload += struct.pack('<H', PAGE_SIZE)          # maxPayloadSize (2 bytes LE)

        # bl_command_header_t
        payload += struct.pack('<I', APP_START_ADDRESS)  # startAddress
        payload += struct.pack('<H', PAGE_ERASE_KEY)     # pageEraseUnlockKey
        payload += struct.pack('<H', PAGE_WRITE_KEY)     # pageWriteUnlockKey
        payload += struct.pack('<H', BYTE_WRITE_KEY)     # byteWriteUnlockKey
        payload += struct.pack('<H', PAGE_READ_KEY)      # pageReadUnlockKey

        # blockLength = 2(blockLength field itself) + 1(blockType) + len(resto)
        # Según el código: sizeof(bl_block_header_t) = sizeof(uint16_t) + sizeof(bl_block_type_t)
        # El campo blockLength dentro del struct almacena el tamaño total del bloque
        block_length = 2 + len(payload)  # 2 bytes del campo blockLength + el resto
        return struct.pack('<H', block_length) + payload

    def build_write_block(self, address: int, page_data: bytes) -> bytes:
        """
        Construye el bloque WRITE_FLASH (blockType=0x02).

        Estructura (dentro de FTP_WRITE_CHUNK payload):
          bl_block_header_t  { blockLength: u16, blockType: u8 }
          bl_command_header_t {
            startAddress      : u32
            pageEraseUnlockKey: u16
            pageWriteUnlockKey: u16
            byteWriteUnlockKey: u16
            pageReadUnlockKey : u16
          }
          data[PAGE_SIZE]
        """
        block_type = BlockType.WRITE_FLASH

        payload = struct.pack('<B', block_type)           # blockType
        # bl_command_header_t
        payload += struct.pack('<I', address)             # startAddress
        payload += struct.pack('<H', PAGE_ERASE_KEY)      # pageEraseUnlockKey
        payload += struct.pack('<H', PAGE_WRITE_KEY)      # pageWriteUnlockKey
        payload += struct.pack('<H', BYTE_WRITE_KEY)      # byteWriteUnlockKey
        payload += struct.pack('<H', PAGE_READ_KEY)       # pageReadUnlockKey
        payload += page_data                              # datos de la página (PAGE_SIZE bytes)

        block_length = 2 + len(payload)
        return struct.pack('<H', block_length) + payload


# ===========================================================================
#  FLUJO PRINCIPAL DE CARGA
# ===========================================================================

def flash_firmware(port: str, hex_path: str, baudrate: int = 115200,
                   dest_mac: str = None, verbose: bool = False):
    """
    Flujo completo de carga de firmware:
      1. Cargar y procesar el .hex
      2. Abrir comunicación XBee
      3. GET CLIENT INFO
      4. START TRANSFER
      5. Enviar bloque UNLOCK
      6. Enviar todas las páginas de flash
      7. GET IMAGE STATE (verificar CRC)
      8. END TRANSFER (el PIC reinicia con el nuevo firmware)
    """

    log = logging.getLogger("Flasher")
    log.info("=" * 60)
    log.info(" XBee MDFU Bootloader Host - PIC18F47Q43")
    log.info("=" * 60)

    # --- Cargar el .hex ---
    log.info(f"\n[1/8] Procesando archivo: {hex_path}")
    try:
        proc = HexProcessor(hex_path)
    except ValueError as e:
        log.error(f"Error al cargar el .hex: {e}")
        return False

    pages = proc.get_app_pages()
    if not pages:
        log.error("No se encontraron páginas de aplicación en el archivo .hex")
        return False

    crc = proc.compute_crc16()

    # --- Abrir puerto serie y XBee ---
    log.info(f"\n[2/8] Abriendo puerto {port} @ {baudrate} bps")
    try:
        xbee = XBeeAPI(port=port, baudrate=baudrate)
    except RuntimeError as e:
        log.error(str(e))
        return False

    # Configurar dirección MAC destino si se proporcionó
    if dest_mac:
        try:
            mac_bytes = bytes.fromhex(dest_mac.replace(':', '').replace('-', ''))
            if len(mac_bytes) != 8:
                raise ValueError("La MAC debe tener 8 bytes (64 bits)")
            xbee.dest_mac = mac_bytes
            log.info(f"Dirección MAC destino configurada: {mac_bytes.hex(':').upper()}")
        except Exception as e:
            log.error(f"Dirección MAC inválida: {e}")
            xbee.close()
            return False

    mdfu = MDFUClient(xbee)

    try:
        # --- GET CLIENT INFO ---
        log.info(f"\n[3/8] Obteniendo información del cliente bootloader...")
        info = mdfu.get_client_info()
        if info is None:
            log.error("No se recibió respuesta al GET CLIENT INFO. ¿Está el PIC en modo bootloader?")
            return False

        # --- START TRANSFER ---
        log.info(f"\n[4/8] Iniciando transferencia (se borrará la Flash de aplicación)...")
        if not mdfu.start_transfer():
            log.error("Fallo en START TRANSFER")
            return False

        # --- ENVIAR BLOQUE UNLOCK ---
        log.info(f"\n[5/8] Enviando bloque UNLOCK_BOOTLOADER...")
        unlock_block = proc.build_unlock_block()
        log.debug(f"Unlock block [{len(unlock_block)} bytes]: {unlock_block.hex(' ').upper()}")
        if not mdfu.write_chunk(unlock_block, timeout=DEFAULT_TIMEOUT_S * 3):
            log.error("Fallo al enviar UNLOCK_BOOTLOADER")
            return False
        log.info("    UNLOCK_BOOTLOADER aceptado ✓")

        # --- ENVIAR PÁGINAS DE FLASH ---
        total_pages = len(pages)
        log.info(f"\n[6/8] Escribiendo {total_pages} páginas de firmware ({total_pages * PAGE_SIZE} bytes)...")

        start_time = time.time()
        for i, (addr, page_data) in enumerate(pages):
            write_block = proc.build_write_block(addr, page_data)
            progress = (i + 1) / total_pages * 100

            log.info(f"    Página {i+1:3d}/{total_pages} @ 0x{addr:06X} [{progress:.1f}%]")
            if verbose:
                log.debug(f"    Block [{len(write_block)} bytes]: {write_block[:16].hex(' ').upper()}...")

            if not mdfu.write_chunk(write_block, timeout=DEFAULT_TIMEOUT_S * 2):
                log.error(f"Fallo al escribir la página @ 0x{addr:06X}")
                return False

        elapsed = time.time() - start_time
        speed   = (total_pages * PAGE_SIZE) / elapsed if elapsed > 0 else 0
        log.info(f"    Escritura completada en {elapsed:.1f}s ({speed:.0f} bytes/s)")

        # --- VERIFICAR IMAGEN (CRC) ---
        log.info(f"\n[7/8] Verificando CRC-16 de la imagen cargada (esperado: 0x{crc:04X})...")
        if not mdfu.get_image_state():
            log.error("Verificación de imagen fallida. El firmware puede estar corrupto.")
            return False
        log.info("    CRC verificado correctamente ✓")

        # --- FIN DE TRANSFERENCIA ---
        log.info(f"\n[8/8] Finalizando transferencia y reiniciando el PIC...")
        mdfu.end_transfer()
        log.info("\n" + "=" * 60)
        log.info(" ✓ FIRMWARE CARGADO EXITOSAMENTE")
        log.info("=" * 60)
        return True

    except KeyboardInterrupt:
        log.warning("\nCancelado por el usuario.")
        return False
    finally:
        xbee.close()


# ===========================================================================
#  PUNTO DE ENTRADA
# ===========================================================================

def setup_logging(verbose: bool):
    level = logging.DEBUG if verbose else logging.INFO
    logging.basicConfig(
        level=level,
        format='%(asctime)s.%(msecs)03d [%(levelname)-7s] %(name)s: %(message)s',
        datefmt='%H:%M:%S'
    )


def main():
    parser = argparse.ArgumentParser(
        description='Carga firmware en un PIC18F47Q43 a través de XBee API (MDFU-FTP)',
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
Ejemplos:
  # Modo básico (el script aprende la MAC del primer paquete recibido):
  python xbee_bootloader_host.py --port COM3 --hex firmware.hex

  # Especificando la MAC del XBee remoto (más confiable):
  python xbee_bootloader_host.py --port COM3 --hex firmware.hex --mac 00:13:A2:00:41:23:45:67

  # Con salida detallada (debug):
  python xbee_bootloader_host.py --port COM3 --hex firmware.hex --verbose

Nota:
  El PIC18F47Q43 debe estar en modo bootloader antes de ejecutar este script.
  Para activarlo, la aplicación debe escribir 0xAA en EEPROM[0x380000] y hacer RESET.
        """
    )
    parser.add_argument('--port',     required=True,        help='Puerto serie del XBee local (ej. COM3, /dev/ttyUSB0)')
    parser.add_argument('--hex',      required=True,        help='Archivo .hex de Intel con el nuevo firmware')
    parser.add_argument('--baud',     type=int, default=115200, help='Baud rate del XBee (default: 115200)')
    parser.add_argument('--mac',      default=None,         help='MAC 64-bit del XBee remoto (ej. 00:13:A2:00:41:23:45:67)')
    parser.add_argument('--timeout',  type=float, default=DEFAULT_TIMEOUT_S, help=f'Timeout por respuesta en segundos (default: {DEFAULT_TIMEOUT_S})')
    parser.add_argument('--verbose',  action='store_true',  help='Salida detallada (debug)')

    args = parser.parse_args()

    setup_logging(args.verbose)

    if not os.path.isfile(args.hex):
        print(f"[ERROR] Archivo no encontrado: {args.hex}")
        sys.exit(1)

    success = flash_firmware(
        port=args.port,
        hex_path=args.hex,
        baudrate=args.baud,
        dest_mac=args.mac,
        verbose=args.verbose,
    )

    sys.exit(0 if success else 1)


if __name__ == '__main__':
    main()
