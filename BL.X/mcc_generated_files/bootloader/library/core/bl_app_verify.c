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
 * @file        bl_app_verify.c
 * @ingroup     mdfu_client_8bit_core
 * 
 * @brief       This file contains APIs to support verification of the
 *              application image space.
 */
 
/**@misradeviation{@required, 7.2} The MACRO is used in the bl_interrupt file as an argument for
 * assembly instrcutions, which requires the value to be a pure hexadecimal number without the appended
 * U or u.
 */

#include <stdint.h>
#include <stdbool.h>
#include "bl_app_verify.h"
#include "bl_config.h"
#include "../../../nvm/nvm.h"

#define CRC_POLYNOMIAL    (0x1021U)
#define CRC_SEED          (0xFFFFU)

#define END_OF_APP          ((uint32_t)BL_APPLICATION_END_ADDRESS - HASH_DATA_SIZE)
#define HASH_STORE_ADDRESS  (END_OF_APP + (uint32_t)1U)
#define HASH_CALC_LENGTH    (HASH_STORE_ADDRESS - (uint32_t)BL_APPLICATION_START_ADDRESS)

static void CRC16_Calculate(flash_address_t startAddress, uint32_t length, uint16_t *crcSeed);
static bl_result_t CRC16_Validate(flash_address_t startAddress, uint32_t length, flash_address_t crcAddress);

#if defined(_PIC18) || defined(AVR_ARCH)

static void CRC16_Calculate(flash_address_t startAddress, uint32_t length, uint16_t *crcSeed)
{
    uint32_t byteIndex;

    flash_address_t startOfPageAddress = FLASH_PageAddressGet(startAddress);

    for (byteIndex = 0U; byteIndex < length; byteIndex++)
    {
        uint8_t readByte = FLASH_Read((flash_address_t) (startOfPageAddress + byteIndex));
        *crcSeed ^= ((uint16_t) readByte << 8U);

        for (uint8_t bit = 8U; bit > 0U; --bit)
        {
            if ((*crcSeed & ((uint16_t) 1U << 15U)) != 0U)
            {
                *crcSeed = (*crcSeed << 1U) ^ CRC_POLYNOMIAL;
            }
            else
            {
                *crcSeed <<= 1U;
            }
        }
    }
}
#elif !defined(_PIC18) && defined(PIC_ARCH)

static void CRC16_Calculate(flash_address_t startAddress, uint32_t length, uint16_t *crcSeed)
{
    uint32_t wordIndex;
    uint8_t byteIndex;
    uint8_t byteArr[2];

    for (wordIndex = 0U; wordIndex < length; wordIndex++)
    {
        uint16_t readWord = (uint16_t)FLASH_Read(startAddress + wordIndex);
        byteArr[1] = (uint8_t) (readWord >> 8U);
        byteArr[0] = (uint8_t) (readWord);
        // Bring the next byte into the checksum.
        for (byteIndex = 0U; byteIndex < 2U; byteIndex++)
        {
            *crcSeed ^= (uint16_t)((uint16_t)byteArr[byteIndex] << 8U);
            for (uint8_t bit = 8U; bit > 0U; --bit)
            {
                if ((*crcSeed & ((uint16_t) 1U << 15U)) != 0U)
                {
                    *crcSeed = (*crcSeed << 1U) ^ CRC_POLYNOMIAL;
                }
                else
                {
                    *crcSeed <<= 1U;
                }
            }
        }
    }
}
#endif

static bl_result_t CRC16_Validate(flash_address_t startAddress, uint32_t length, flash_address_t crcAddress)
{
    bl_result_t result = BL_FAIL;
    uint16_t crc = CRC_SEED;
    bool refAddrInsideEvaluatedArea = (((crcAddress + 1U) >= startAddress) && (crcAddress < (startAddress + length)));
    bool refAddrOutsideFlash = ((crcAddress + 1U) >= PROGMEM_SIZE);

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
        uint16_t refCRC;

        CRC16_Calculate(startAddress, length, &crc);
#if defined(_PIC18) || defined(AVR_ARCH)
        uint16_t byte0 = (uint16_t)FLASH_Read(crcAddress);
        uint16_t byte1 = (uint16_t)FLASH_Read(crcAddress + 1U);

        refCRC = (byte0 | (byte1 << 8U));
#elif !defined(_PIC18) && defined(PIC_ARCH)
        uint16_t byte0 = (uint8_t)FLASH_Read(crcAddress);
        uint16_t byte1 = (uint8_t)FLASH_Read(crcAddress + 1U);

        refCRC = (uint16_t)(byte0 | (byte1 << 8U));
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

bl_result_t BL_ImageVerify(void)
{
    bl_result_t result = BL_ERROR_VERIFICATION_FAIL;
    /* cppcheck-suppress misra-c2012-7.2; This rule cannot be followed due to assembly syntax requirements. */
    result = (bl_result_t)CRC16_Validate((flash_address_t)BL_APPLICATION_START_ADDRESS, (uint32_t)HASH_CALC_LENGTH, (flash_address_t)HASH_STORE_ADDRESS);
    
    return result;
}