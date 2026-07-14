/**
 * © 2025 Microchip Technology Inc. and its subsidiaries.
 *
 * Subject to your compliance with these terms, you may use Microchip 
 * software and any derivatives exclusively with Microchip products. 
 * It is your responsibility to comply with third party license terms 
 * applicable to your use of third party software (including open 
 * source software) that may accompany Microchip software.
 *
 * THIS SOFTWARE IS SUPPLIED BY MICROCHIP "AS IS". NO WARRANTIES, 
 * WHETHER EXPRESS, IMPLIED OR STATUTORY, APPLY TO THIS SOFTWARE, 
 * INCLUDING ANY IMPLIED WARRANTIES OF NON-INFRINGEMENT, 
 * MERCHANTABILITY, AND FITNESS FOR A PARTICULAR PURPOSE.
 *
 * IN NO EVENT WILL MICROCHIP BE LIABLE FOR ANY INDIRECT, SPECIAL, 
 * PUNITIVE, INCIDENTAL OR CONSEQUENTIAL LOSS, DAMAGE, COST OR EXPENSE  
 * OF ANY KIND WHATSOEVER RELATED TO THE SOFTWARE, HOWEVER CAUSED,
 * EVEN IF MICROCHIP HAS BEEN ADVISED OF THE POSSIBILITY OR THE 
 * DAMAGES ARE FORESEEABLE. TO THE FULLEST EXTENT ALLOWED BY LAW, 
 * MICROCHIP'S TOTAL LIABILITY ON ALL CLAIMS IN ANY WAY RELATED TO 
 * THIS SOFTWARE WILL NOT EXCEED THE AMOUNT OF FEES, IF ANY, THAT YOU 
 * HAVE PAID DIRECTLY TO MICROCHIP FOR THIS SOFTWARE.
 * 
 * @file        bl_boot_verify.c
 * @ingroup     mdfu_client_8bit_core

 * @brief       Bootloader image integrity verification using CRC32.
 *
 */

#include "bl_boot_verify.h"
 
#define CRC_POLYNOMIAL    (0xEDB88320U)
#define CRC_SEED          (0xFFFFFFFFU)
#define CRC_XorOut        (0x00000000U)

static void CRC32_Calculate(flash_address_t startAddress, uint32_t length, uint32_t *crcSeed);

#if defined(_PIC18) || defined(AVR_ARCH)

static void CRC32_Calculate(flash_address_t startAddress, uint32_t length, uint32_t *crcSeed)
{
    uint32_t byteIndex;

    for (byteIndex = 0U; byteIndex < length; byteIndex++)
    {
        uint8_t readByte = FLASH_Read((flash_address_t) (startAddress + byteIndex));

        *crcSeed ^= (uint32_t) readByte;

        for (uint8_t bit = 8U; bit > 0U; --bit)
        {
            if ((*crcSeed & 0x01U) != 0U)
            {
                *crcSeed = (*crcSeed >> 1U) ^ CRC_POLYNOMIAL;
            }
            else
            {
                *crcSeed >>= 1U;
            }
        }
    }
    *crcSeed ^= CRC_XorOut;
}
#elif !defined(_PIC18) && defined(PIC_ARCH)

static void CRC32_Calculate(flash_address_t startAddress, uint32_t length, uint32_t *crcSeed)
{
    uint16_t wordIndex;
    uint16_t byteIndex;
    uint8_t byteArr[2];

    for (wordIndex = 0U; wordIndex < length; wordIndex++)
    {
        uint16_t readWord = (uint16_t)FLASH_Read((flash_address_t) startAddress + wordIndex);
        byteArr[1] = (uint8_t) (readWord >> 8U);
        byteArr[0] = (uint8_t) readWord;

        for (byteIndex = 0U; byteIndex < 2U; byteIndex++)
        {
            *crcSeed ^= byteArr[byteIndex];
            for (uint8_t bit = 8U; bit > 0U; --bit)
            {
                if ((*crcSeed & 0x01U) != 0U)
                {
                    *crcSeed = (*crcSeed >> 1U) ^ CRC_POLYNOMIAL;
                }
                else
                {
                    *crcSeed >>= 1U;
                }
            }
        }
    }
    *crcSeed ^= CRC_XorOut;
}
#endif

bl_result_t CRC32_BOOT_Validate(flash_address_t startAddress, uint32_t length, flash_address_t refAddress)
{
    bl_result_t result = BL_FAIL;
    uint32_t crc = CRC_SEED;

    bool refAddrInsideEvaluatedArea = (((refAddress + 3U) >= startAddress) && (refAddress < (startAddress + length)));
    bool refAddrOutsideFlash = ((refAddress + 3U) >= PROGMEM_SIZE);

    if ((0U == length) || ((startAddress + length) > PROGMEM_SIZE))
    {
        result = BL_ERROR_INVALID_ARGUMENTS;
    }
    else if (refAddrInsideEvaluatedArea || refAddrOutsideFlash)
    {
        result = BL_ERROR_ADDRESS_OUT_OF_RANGE;
    }
    else
    {
        CRC32_Calculate(startAddress, length, &crc);
#if defined(_PIC18) || defined(AVR_ARCH)
        uint32_t byte0 = (uint32_t)FLASH_Read(refAddress);
        uint32_t byte1 = (uint32_t)FLASH_Read(refAddress + 1U);
        uint32_t byte2 = (uint32_t)FLASH_Read(refAddress + 2U);
        uint32_t byte3 = (uint32_t)FLASH_Read(refAddress + 3U);

        uint32_t refCRC = ((byte0)) | ((byte1) << 8U) | ((byte2) << 16U) | ((byte3) << 24U);
#elif !defined(_PIC18) && defined(PIC_ARCH)
        uint32_t byte0 = (uint32_t)FLASH_Read(refAddress);
        uint32_t byte1 = (uint32_t)FLASH_Read(refAddress + 1U);
        uint32_t byte2 = (uint32_t)FLASH_Read(refAddress + 2U);
        uint32_t byte3 = (uint32_t)FLASH_Read(refAddress + 3U);

        uint32_t refCRC = ((byte0 & 0x00FFU)) |
                    ((byte1 & 0x00FFU) << 8U) |
                    ((byte2 & 0x00FFU) << 16U) |
                    ((byte3 & 0x00FFU) << 24U);
#endif
        if (refCRC != crc)
        {
            result = BL_ERROR_VERIFICATION_FAIL;
        }
        else
        {
            result = BL_PASS;
        }
    }
    return result;
}
