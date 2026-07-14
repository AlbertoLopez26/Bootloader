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
 * @file        bl_config.h
 * @ingroup     mdfu_client_8bit_core
 *
 * @brief       This file contains macros and type definitions related to the
 *              bootloader client device configuration and the bootloader settings.
 */

 /**@misradeviation{@advisory, 2.3} 
 * This rule will not be followed as the application might require the generated types.
 */

/**@misradeviation{@advisory, 2.4}
 * This rule will not be followed as the application might require the generated tags.
 */

/**@misradeviation{@advisory, 2.5}
 * This rule will not be followed as the application might require the generated macros.
*/


#ifndef BL_BOOT_CONFIG_H
/* cppcheck-suppress misra-c2012-2.5; This is a false positive. */
#define BL_BOOT_CONFIG_H

#include <stdint.h>

/**
 * @ingroup mdfu_client_8bit_core
 * @def PIC_ARCH
 * Corresponds to the current device architecture.
 * This macro is used to conditionally compile parts of the code needed
 * for specific architectures inside the bootloader core firmware.
 */
#ifndef PIC_ARCH
#define PIC_ARCH /* cppcheck-suppress misra-c2012-2.5; This is a false positive. */
#endif

#define IS_VERIFICATION_SCHEME_CRC32 (0U)

/**
* @ingroup mdfu_client_8bit_core
* @def BL_BOOT_VERIFICATION_ENABLED
* Defines whether the verification of bootloader space using CRC32 is enabled.
*/
#define BL_BOOT_VERIFICATION_ENABLED (0)

/**
 * @ingroup mdfu_client_8bit_core
 * @def BL_IMAGE_FORMAT_MAJOR_VERSION
 * Represents the major version of the image format that is
 * understood by the bootloader core. \n
 */
#define BL_IMAGE_FORMAT_MAJOR_VERSION (0x00) /* cppcheck-suppress misra-c2012-2.5; This is a false positive. */
/**
 * @ingroup mdfu_client_8bit_core
 * @def BL_IMAGE_FORMAT_MINOR_VERSION
 * Represents the minor version of the image format that is
 * understood by the bootloader core. \n
 */
#define BL_IMAGE_FORMAT_MINOR_VERSION (0x03) /* cppcheck-suppress misra-c2012-2.5; This is a false positive. */
/**
 * @ingroup mdfu_client_8bit_core
 * @def BL_IMAGE_FORMAT_PATCH_VERSION
 * Represents the patch version of the image format that is
 * understood by the bootloader core. \n
 */
#define BL_IMAGE_FORMAT_PATCH_VERSION (0x00) /* cppcheck-suppress misra-c2012-2.5; This is a false positive. */
/**
 * @ingroup mdfu_client_8bit_core
 * @def BL_VECTORED_INTERRUPTS_ENABLED
 * Indicates that the bootloader supports vectored interrupts in the application.
 */
#define BL_VECTORED_INTERRUPTS_ENABLED (1) /* cppcheck-suppress misra-c2012-2.5; This is a false positive. */

/**
 * @ingroup mdfu_client_8bit_core
 * @def BL_APPLICATION_START_ADDRESS
 * Start of the application memory space.
 */
#define BL_APPLICATION_START_ADDRESS (0x3000) /* cppcheck-suppress misra-c2012-2.5; This is a false positive. */
/**
 * @ingroup mdfu_client_8bit_core
 * @def BL_APPLICATION_INTERRUPT_VECTOR_LOW
 * Start address of the low-priority interrupt vector.
 */
#define BL_APPLICATION_INTERRUPT_VECTOR_LOW (0x3018) /* cppcheck-suppress misra-c2012-2.5; This is a false positive. */
/**
 * @ingroup mdfu_client_8bit_core
 * @def BL_APPLICATION_INTERRUPT_VECTOR_HIGH
 * Start address of the high-priority interrupt vector.
 */
#define BL_APPLICATION_INTERRUPT_VECTOR_HIGH (0x3008) /* cppcheck-suppress misra-c2012-2.5; This is a false positive. */
/**
 * @ingroup mdfu_client_8bit_core
 * @def BL_DEVICE_ID_START_ADDRESS_U
 * Device ID address.
 */
#define BL_DEVICE_ID_START_ADDRESS_U (0x3FFFFEU) /* cppcheck-suppress misra-c2012-2.5; This is a false positive. */
/**
 * @ingroup mdfu_client_8bit_core
 * @def BL_APPLICATION_END_ADDRESS
 * End of the application memory space.
 */
#define BL_APPLICATION_END_ADDRESS (0x1FFFF) /* cppcheck-suppress misra-c2012-2.5; This is a false positive. */
/**
 * @ingroup mdfu_client_8bit_core
 * @def BL_IMAGE_PARTITION_SIZE
 * Defined size of the application memory space.
 */
#define BL_IMAGE_PARTITION_SIZE (0x1D000U) /* cppcheck-suppress misra-c2012-2.5; This is a false positive. */
/**
 * @ingroup mdfu_client_8bit_core
 * @def BL_STAGING_IMAGE_START
 * Start of the application download space.
 */
#define BL_STAGING_IMAGE_START (0x3000) /* cppcheck-suppress misra-c2012-2.5; This is a false positive. */
/**
 * @ingroup mdfu_client_8bit_core
 * @def BL_STAGING_IMAGE_END
 * End of the application download space.
 */
#define BL_STAGING_IMAGE_END (0x1FFFF)
/**
 * @ingroup mdfu_client_8bit_core
 * @def BL_STAGING_IMAGE_ID
 * Image area ID that identifies the download location of the transferred data.
 */
#define BL_STAGING_IMAGE_ID (0U) /* cppcheck-suppress misra-c2012-2.5; This is a false positive. */
/**
 * @ingroup mdfu_client_8bit_core
 * @def BL_APPLICATION_IMAGE_COUNT
 * Number of application image spaces configured.
 */
#define BL_APPLICATION_IMAGE_COUNT (1U)

/**
* @ingroup mdfu_client_8bit_core
* @def HASH_DATA_SIZE
* Size of the hash data in bytes.
*/
#define HASH_DATA_SIZE (2U)


/**
* @def ECDSA_VERIFICATION_ENABLED
* @brief ECDSA-SHA256 verification is disabled.
*/
#define ECDSA_VERIFICATION_ENABLED     (0U)


/**
* @ingroup mdfu_client_8bit_core
* @struct bl_footer_data_t
* @brief Contains metadata for the bootloader footer.
* @var bl_footer_data_t::verificationEndAddress
* Contains the end address for verification.
* @var bl_footer_data_t::verificationStartAddress
* Contains the start address for verification.
* @var bl_footer_data_t::verificationData
* Contains the verification hash value for verification.
*/
typedef struct
{
    uint32_t verificationEndAddress;
    uint32_t verificationStartAddress; 
    uint16_t verificationData;
} bl_footer_data_t;
#endif // BL_BOOT_CONFIG_H
