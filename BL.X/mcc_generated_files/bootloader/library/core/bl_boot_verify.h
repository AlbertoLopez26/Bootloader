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

 * @file        bl_boot_verify.h
 * @ingroup     mdfu_client_8bit_core
 * @brief       This file contains the API prototypes or remapped API Alias to perform
 *              bootloader memory space verification.
 * 
 */
#ifndef BOOT_VERIFY_H
#define BOOT_VERIFY_H

#include "bl_app_verify.h" 
#if (IS_VERIFICATION_SCHEME_CRC32 == 1)
/**
 * @ingroup mdfu_client_8bit_core
 * @def CRC32_BOOT_Validate
 * @brief Alias for CRC32_Validate function when verification scheme is CRC32.
 */
#define CRC32_BOOT_Validate CRC32_Validate

#else
#include <stdint.h>
#include "../../../nvm/nvm.h"  
#include "bl_result_type.h" 

/**
 * @ingroup mdfu_client_8bit_core
 * @brief Bootloader space validation using CRC32.
 *
 * Validates the bootloader firmware image in Flash memory using CRC32. This API compares the
 * computed CRC32 for the given bootloader range with a reference value located at refAddress.
 *
 * @param[in]  startAddress  Start address of the region to validate.
 * @param[in]  length        Length of the region in bytes.
 * @param[in]  refAddress    Address containing the reference CRC32 value.
 * @return     @ref     bl_result_t   Result of validation operation (e.g., success, error).
 */
bl_result_t CRC32_BOOT_Validate(flash_address_t startAddress, uint32_t length, flash_address_t refAddress);

#endif 

#endif // BOOT_VERIFY_H
