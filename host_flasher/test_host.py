#!/usr/bin/env python3
"""
Test unitario para las utilidades del script xbee_bootloader_host.py.
Ejecutar con: python test_host.py
"""
import struct
import sys
sys.path.insert(0, '.')
from xbee_bootloader_host import (
    crc16_calculate, crc16_bytes, HexProcessor,
    DEVICE_ID, APP_START_ADDRESS, PAGE_SIZE,
    IMAGE_FORMAT_MAJOR, IMAGE_FORMAT_MINOR, IMAGE_FORMAT_PATCH,
    PAGE_ERASE_KEY, PAGE_WRITE_KEY, BYTE_WRITE_KEY, PAGE_READ_KEY,
    BlockType
)

def test_crc16():
    # CRC-16/CCITT-FALSE sobre "123456789" debe ser 0x29B1
    assert crc16_calculate(b'123456789') == 0x29B1, "CRC-16 básico FALLA"
    print("✓ test_crc16")

def test_crc16_bytes():
    result = crc16_bytes(b'123456789')
    assert result == struct.pack('<H', 0x29B1), "crc16_bytes FALLA"
    print("✓ test_crc16_bytes")

def test_unlock_block_structure():
    """Verifica que el bloque UNLOCK tenga la estructura correcta."""
    # Crear un HexProcessor ficticio para testear build_unlock_block
    class FakeProc:
        ih = None
        log = __import__('logging').getLogger('test')
        build_unlock_block = HexProcessor.build_unlock_block

    proc = object.__new__(HexProcessor)
    proc.log = __import__('logging').getLogger('test')
    block = HexProcessor.build_unlock_block(proc)

    offset = 0
    block_length = struct.unpack_from('<H', block, offset)[0]; offset += 2
    block_type   = struct.unpack_from('<B', block, offset)[0]; offset += 1
    patch        = struct.unpack_from('<B', block, offset)[0]; offset += 1
    minor        = struct.unpack_from('<B', block, offset)[0]; offset += 1
    major        = struct.unpack_from('<B', block, offset)[0]; offset += 1
    device_id    = struct.unpack_from('<I', block, offset)[0]; offset += 4
    max_payload  = struct.unpack_from('<H', block, offset)[0]; offset += 2
    start_addr   = struct.unpack_from('<I', block, offset)[0]; offset += 4
    erase_key    = struct.unpack_from('<H', block, offset)[0]; offset += 2
    write_key    = struct.unpack_from('<H', block, offset)[0]; offset += 2
    byte_key     = struct.unpack_from('<H', block, offset)[0]; offset += 2
    read_key     = struct.unpack_from('<H', block, offset)[0]; offset += 2

    assert block_type  == BlockType.UNLOCK_BOOTLOADER, f"blockType={block_type}"
    assert major       == IMAGE_FORMAT_MAJOR,           f"major={major}"
    assert minor       == IMAGE_FORMAT_MINOR,           f"minor={minor}"
    assert patch       == IMAGE_FORMAT_PATCH,           f"patch={patch}"
    assert device_id   == DEVICE_ID,                    f"deviceId=0x{device_id:08X}"
    assert max_payload == PAGE_SIZE,                    f"maxPayload={max_payload}"
    assert start_addr  == APP_START_ADDRESS,            f"startAddr=0x{start_addr:08X}"
    assert erase_key   == PAGE_ERASE_KEY,               f"eraseKey=0x{erase_key:04X}"
    assert write_key   == PAGE_WRITE_KEY,               f"writeKey=0x{write_key:04X}"
    assert byte_key    == BYTE_WRITE_KEY,               f"byteKey=0x{byte_key:04X}"
    assert read_key    == PAGE_READ_KEY,                f"readKey=0x{read_key:04X}"

    expected_len = 2 + len(block) - 2  # blockLength propio + resto
    assert block_length == len(block), f"blockLength={block_length} vs {len(block)}"

    print(f"✓ test_unlock_block_structure (tamaño total={len(block)} bytes)")

def test_write_block_structure():
    """Verifica el bloque WRITE_FLASH."""
    proc = object.__new__(HexProcessor)
    proc.log = __import__('logging').getLogger('test')

    test_addr = 0x3000
    test_data = bytes(range(256))
    block = HexProcessor.build_write_block(proc, test_addr, test_data)

    offset = 0
    block_length = struct.unpack_from('<H', block, offset)[0]; offset += 2
    block_type   = struct.unpack_from('<B', block, offset)[0]; offset += 1
    start_addr   = struct.unpack_from('<I', block, offset)[0]; offset += 4

    assert block_type == BlockType.WRITE_FLASH,  f"blockType={block_type}"
    assert start_addr == test_addr,              f"startAddr=0x{start_addr:06X}"
    assert len(block) == 2 + 1 + 4 + 2+2+2+2 + PAGE_SIZE, f"tamaño incorrecto={len(block)}"

    print(f"✓ test_write_block_structure (tamaño total={len(block)} bytes)")

def test_xbee_frame_checksum():
    """Verifica la lógica de checksum XBee."""
    frame_data = bytes([0x10, 0x00]) + b'\x00\x13\xA2\x00\x41\x23\x45\x67' + b'\xFF\xFE' + bytes([0x00, 0x00]) + b'\x01\x02\x03'
    checksum = (0xFF - (sum(frame_data) & 0xFF)) & 0xFF
    verification = (sum(frame_data) + checksum) & 0xFF
    assert verification == 0xFF, f"Checksum XBee incorrecto: {verification}"
    print("✓ test_xbee_frame_checksum")

if __name__ == '__main__':
    import logging
    logging.basicConfig(level=logging.WARNING)

    tests = [
        test_crc16,
        test_crc16_bytes,
        test_unlock_block_structure,
        test_write_block_structure,
        test_xbee_frame_checksum,
    ]

    passed = 0
    for test in tests:
        try:
            test()
            passed += 1
        except AssertionError as e:
            print(f"✗ {test.__name__}: {e}")
        except Exception as e:
            print(f"✗ {test.__name__}: EXCEPCIÓN - {e}")

    print(f"\nResultado: {passed}/{len(tests)} tests pasaron")
    sys.exit(0 if passed == len(tests) else 1)
