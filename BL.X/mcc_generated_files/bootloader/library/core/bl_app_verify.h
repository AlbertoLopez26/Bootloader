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
 * @file        bl_app_verify.h
 * @ingroup     mdfu_client_8bit_core
 * 
 * @brief       This file contains the API prototypes to perform
 *              application image verification.
 */

#ifndef BL_VERIFY_H
/* cppcheck-suppress misra-c2012-2.5; This is a false positive. */
#define	BL_VERIFY_H

#include "bl_result_type.h"
#include "bl_config.h"
#include "bl_memory.h"

/**
 * @ingroup mdfu_client_8bit_core
 * @brief Performs a verification sequence on the staging area image memory space.
 * @param None.
 * @return @ref BL_PASS - Bootloader verified the application image with no errors \n
 * @return @ref BL_ERROR_VERIFICATION_FAIL - Bootloader image verification failed \n
 * @return @ref BL_ERROR_COMMAND_PROCESSING - Bootloader image verification failed due to incorrect processing data \n
 * @return @ref BL_ERROR_ADDRESS_OUT_OF_RANGE - Bootloader image verification failed due to incorrect addresses \n
 * @return @ref BL_ERROR_ROLLBACK_FAILURE - Bootloader image verification failed due to anti-rollback feature \n
 */
bl_result_t BL_ImageVerify(void);

#if BL_APPLICATION_IMAGE_COUNT > 1
/**
 * @ingroup mdfu_client_8bit_core
 * @brief Performs a verification sequence on the given application image memory space.
 * @param None.
 * @return @ref BL_PASS - Bootloader verified the application image with no errors \n
 * @return @ref BL_ERROR_VERIFICATION_FAIL - Bootloader image verification failed \n
 * @return @ref BL_ERROR_COMMAND_PROCESSING - Bootloader image verification failed due to incorrect processing data \n
 * @return @ref BL_ERROR_ADDRESS_OUT_OF_RANGE - Bootloader image verification failed due to incorrect addresses \n
 */
bl_result_t BL_ImageVerifyById(uint8_t installLocationId);
#endif

#if ((BL_BOOT_VERIFICATION_ENABLED == 1 ) && (IS_VERIFICATION_SCHEME_CRC32 == 1)) 
/**
 * @ingroup mdfu_client_8bit_core
 * @brief Validates the CRC32 checksum of a specified memory region against a reference value in flash.
 *
 * This function calculates the CRC32 checksum over the memory region starting at startAddress
 * and spanning length bytes, then compares the computed value against the reference CRC32 value
 * stored at refAddress in flash. If they match, the function returns BL_PASS, otherwise a
 * corresponding error code indicating the type of failure.
 *
 * @param[in]  startAddress     The starting flash address of the memory region to validate.
 * @param[in]  length           The length in bytes of the memory region to validate.
 * @param[in]  refAddress       The flash address containing the reference CRC32 value to compare.
 *
 * @return     @ref BL_PASS                   - CRC32 value matches the reference.
 * @return     @ref BL_ERROR_VERIFICATION_FAIL- CRC32 value does not match the reference.
 * @return     @ref BL_ERROR_ADDRESS_OUT_OF_RANGE - Provided addresses are not within valid range.
 * @return     @ref BL_ERROR_COMMAND_PROCESSING   - Other internal validation or processing error occurred.
 */
bl_result_t CRC32_Validate(flash_address_t startAddress, uint32_t length, flash_address_t refAddress);
#endif
#endif // BL_VERIFY_H