/**
 * @file    com_adapter.c
 * @brief   Implementation file for the XBee API communication adapter layer using UART.
 */

#include "com_adapter.h"
#include "../../../../xbee.h"

#ifndef SERCOM_IsRxReady
#define SERCOM_IsRxReady        SERCOM__IsRxReady
#endif

// Variables estaticas del modulo XBee (MAC y 16-bit address de origen)
static uint8_t senderMAC[8] = {0};
static uint8_t sender16Bit[2] = {0};
static uint16_t MaxBufferLength = 0U;

// Funcion auxiliar estatica local para enviar por UART y sumar al Checksum
static uint8_t SendAndCheck(uint8_t val, uint8_t checksum) {
    UART1_Write(val);
    return (uint8_t)(checksum + val);
}

/* Reemplazo o Wrapper de COM_FrameTransfer */
com_adapter_result_t COM_FrameTransfer(uint8_t *destBuffer, uint16_t *receiveCount)
{
    static enum {
        XB_WAIT_START, XB_READ_LEN_MSB, XB_READ_LEN_LSB, XB_READ_DATA, XB_VERIFY_CHK
    } state = XB_WAIT_START;
    
    static uint16_t xbeeLen = 0;
    static uint16_t bytesRead = 0;
    static uint8_t checksum = 0;
    static uint16_t payloadIndex = 0;
    static bool discardFrame = false;

    // Recuperar el UART si hay errores de Overrun o Framing
    if (UART1_ErrorGet() != 0U)
    {
        U1ERRIRbits.FERIF = 0;
        U1ERRIRbits.RXFOIF = 0;
        U1ERRIRbits.PERIF = 0;
    }

    // Procesar todos los bytes disponibles en el buffer de RX del UART1
    while (UART1_IsRxReady()) 
    {
        uint8_t byte = UART1_Read();
        
        switch (state)
        {
            case XB_WAIT_START:
                if (byte == XBEE_START_DELIMITER) {
                    state = XB_READ_LEN_MSB;
                }
                break;
                
            case XB_READ_LEN_MSB:
                xbeeLen = (uint16_t)(byte << 8);
                state = XB_READ_LEN_LSB;
                break;
                
            case XB_READ_LEN_LSB:
                xbeeLen |= byte;
                bytesRead = 0;
                checksum = 0;
                payloadIndex = 0;
                discardFrame = false;
                state = (xbeeLen > 0) ? XB_READ_DATA : XB_WAIT_START;
                break;
                
            case XB_READ_DATA:
                checksum += byte;
                
                // Byte 0: Tipo de trama (Debe ser 0x90 para paquetes recibidos del Host)
                if (bytesRead == 0) {
                    if (byte != XBEE_RX_FRAME_TYPE) {
                        discardFrame = true; // Descartamos tramas que no sean de datos RX (ej. Tx Status 0x8B)
                    }
                }
                
                if (!discardFrame) {
                    // Bytes 1 a 8: MAC Address del remitente (lo guardamos para responderle)
                    if (bytesRead >= 1 && bytesRead <= 8) {
                        senderMAC[bytesRead - 1] = byte;
                    }
                    // Bytes 9 y 10: Direccion de red de 16 bits
                    else if (bytesRead >= 9 && bytesRead <= 10) {
                        sender16Bit[bytesRead - 9] = byte;
                    }
                    // Byte 11: Opciones de recepcion (lo ignoramos)
                    
                    // Bytes 12 en adelante: PAYLOAD REAL DEL BOOTLOADER
                    else if (bytesRead >= 12) {
                        if (payloadIndex < MaxBufferLength) {
                            destBuffer[payloadIndex++] = byte;
                        } else {
                            // Evitar desbordamiento de buffer
                            state = XB_WAIT_START;
                            return COM_BUFFER_ERROR;
                        }
                    }
                }
                
                bytesRead++;
                if (bytesRead >= xbeeLen) {
                    state = XB_VERIFY_CHK;
                }
                break;
                
            case XB_VERIFY_CHK:
                state = XB_WAIT_START;
                // En XBee, la suma de todos los bytes de datos + checksum debe dar 0xFF
                if (((checksum + byte) & 0xFF) == 0xFF) {
                    if (discardFrame) {
                        // Trama descartada correctamente procesada, seguir leyendo en el bucle
                        break;
                    }
                    // El payload fue extraido con exito.
                    *receiveCount = payloadIndex;
                    return COM_PASS;
                }
                if (discardFrame) {
                    break; // Ignorar checksum de tramas no deseadas
                }
                return COM_TRANSPORT_FAILURE; // Checksum invalido -> FTP retransmitira
        }
    }
    
    // Si aun estamos ensamblando la trama, le decimos a FTP_Task que estamos ocupados
    return COM_BUSY;
}

/* Reemplazo o Wrapper de COM_FrameSet */
com_adapter_result_t COM_FrameSet(uint8_t *sourceBuffer, uint16_t sendCount)
{
    // Longitud del area de datos del XBee (14 bytes de cabecera TX + payload del bootloader)
    // 1(Type) + 1(ID) + 8(MAC) + 2(16bit Addr) + 1(Bcast Radius) + 1(Options) = 14 bytes
    uint16_t xbeeDataLen = 14 + sendCount;
    uint8_t checksum = 0;
    
    // 1. Enviar delimitador de inicio y longitud
    UART1_Write(XBEE_START_DELIMITER);
    UART1_Write((uint8_t)(xbeeDataLen >> 8));
    UART1_Write((uint8_t)(xbeeDataLen & 0xFF));
    
    // 2. Cabecera XBee Transmit Request (0x10)
    checksum = SendAndCheck(XBEE_TX_FRAME_TYPE, checksum); // 0x10
    checksum = SendAndCheck(0x00, checksum);               // ID de trama = 0x00 deshabilita tramas de estado Tx Status
    
    // 3. Direccion MAC de destino (la misma que nos envio el paquete)
    for (uint8_t i = 0; i < 8; i++) {
        checksum = SendAndCheck(senderMAC[i], checksum);
    }
    
    // 4. Direccion de 16 bits (0xFFFE si se desconoce, o la que recibimos)
    checksum = SendAndCheck(sender16Bit[0], checksum);
    checksum = SendAndCheck(sender16Bit[1], checksum);
    
    // 5. Radio de Broadcast (0x00 = maximo) y Opciones de TX (0x00)
    checksum = SendAndCheck(0x00, checksum);
    checksum = SendAndCheck(0x00, checksum);
    
    // 6. ENVIAR PAYLOAD DEL BOOTLOADER (Las respuestas de FTP_Task)
    for (uint16_t i = 0; i < sendCount; i++) {
        checksum = SendAndCheck(sourceBuffer[i], checksum);
    }
    
    // 7. Enviar Checksum final del XBee
    UART1_Write((uint8_t)(0xFF - checksum));
    
    return COM_PASS;
}

com_adapter_result_t COM_Initialize(uint16_t maximumBufferLength)
{
    com_adapter_result_t result = COM_FAIL;
    if (maximumBufferLength != 0U)
    {
        MaxBufferLength = maximumBufferLength;
        SERCOM_Initialize();
        result = COM_PASS;
    }
    else
    {
        result = COM_INVALID_ARG;
    }

    return result;
}
