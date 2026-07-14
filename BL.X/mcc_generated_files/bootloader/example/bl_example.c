/**
 * Â© 2025 Microchip Technology Inc. and its subsidiaries.
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
 * @file        bl_example.c
 * @ingroup     mdfu_client_8bit
 *
 * @brief       This file contains APIs for running a bootloader update process
 *              using the FTP Handler and bootloader APIs.
 */
#include "../../nvm/nvm.h"
#include "../library/core/bl_core.h"
#include "../library/core/bl_app_verify.h"
#include "../library/core/ftp/bl_ftp.h"
#include "../library/core/bl_interrupt.h"
#include "../../system/pins.h"
#if BL_BOOT_VERIFICATION_ENABLED == 1  
#include "../library/core/bl_boot_verify.h"
#endif
#include "bl_example.h"
#include "../../../config.h"

/**
 * @ingroup mdfu_client_8bit
 * @def BOOTLOADER_START_ADDRESS
 * Defines the start address of the bootloader in flash memory.
 * This value is used by the bootloader and application to identify
 * the memory region reserved for the bootloader operations.
 */
#define BOOTLOADER_START_ADDRESS (0x0000U)
#define BOOTLOADER_FLAG_ADDRESS  EEPROM_BOOT_FLAG_ADDRESS


/**
 * @ingroup mdfu_client_8bit
 * @def BL_INDICATOR_ON
 * This is a macro for enabling the bootloader indicator pin.
 * When the pin is set to start high, the bootloader will assume
 * that it needs to drive the pin low to enable it.
 */
#define BL_INDICATOR_ON             BL_INDICATOR_SetLow

/**
 * @ingroup mdfu_client_8bit
 * @def BL_INDICATOR_OFF
 * This is a macro for disabling the bootloader indicator pin.
 * When the pin is set to start high, the bootloader will assume
 * that it needs to drive the pin high to disable it.
 */
#define BL_INDICATOR_OFF            BL_INDICATOR_SetHigh

typedef enum
{
#if BL_BOOT_VERIFICATION_ENABLED == 1  
    BOOTSCAN,  
#endif
    BOOTLOADER,
    APPLICATION,
    ERROR_STATE,
} bootloader_state_t;

static bootloader_state_t BootState;

static bool ForcedEntryCheck(void);

void BL_Example(void)
{
#warning "Customize the process logic to handle the bootloader processes."

    bl_result_t result = BL_FAIL;

    switch (BootState)
    {
    case APPLICATION:
        BL_INDICATOR_OFF();
        // switch the interrupt flag to handle application interrupts 
        bootloaderIsRunning = 0;
        BL_ApplicationStart();
        break;
#if BL_BOOT_VERIFICATION_ENABLED == 1  
    case BOOTSCAN:
        result = CRC32_BOOT_Validate((flash_address_t)0x0000,(uint32_t)(BL_APPLICATION_START_ADDRESS -HASH_DATA_SIZE),(flash_address_t)(BL_APPLICATION_START_ADDRESS - HASH_DATA_SIZE));
        /* CRC Calculation is successful */
        if (BL_PASS == result) 
        {
            BootState = BOOTLOADER;
        }
        else 
        {
            BootState = ERROR_STATE;
        }
        break;
#endif
    case BOOTLOADER:
        BL_INDICATOR_ON();
        result = FTP_Task();
        break;
        default:
        // Unknown State; Do nothing
        break;
    }

    if ((bl_result_t)BL_ERROR_VERIFICATION_FAIL == result)
    {
#warning "Handle a failed bootload image however the user sees fit."
        BootState = APPLICATION;
    }
}

bl_example_result_t BL_ExampleInitialize(void)
{
    // Set the interrupt logic for the bootloader
    bootloaderIsRunning = 1;
    // Initialize the FTP handler
    bl_result_t initStatus = FTP_Initialize();

    if((bl_result_t)BL_PASS == initStatus)
    {
#warning "Customize the Initialization steps for the startup process and set the BootState accordingly."
        // Make assumption: We always start in bootload state
#if BL_BOOT_VERIFICATION_ENABLED == 1  
        BootState = BOOTSCAN; 
#else
        BootState = BOOTLOADER;
#endif
        /**
         * On startup we must figure out what the bootloader is being requested to do.
         * If forced entry is being requested, we can short cut the verification scheme.
         * Otherwise check for a valid application
         */
        bool isForcedEntry = ForcedEntryCheck();
        bool isImageVerified = (bool)(BL_PASS == BL_ImageVerify());
        if ((!isForcedEntry) && isImageVerified)
        {
            // Set the application state
            BootState = APPLICATION;
        }
    }
    else
    {
        BootState = ERROR_STATE;
    }
    return EXAMPLE_OK;
}

static bool ForcedEntryCheck(void)
{
    bool result = false;

    // Pequeño retardo de estabilización en el arranque (buena práctica que incluía el código original)
    for (uint8_t i = 0U; i != 0xFFU; i++)
    {
        asm("nop");
    }

    // Leer el byte desde la memoria EEPROM
    uint8_t flag = EEPROM_Read(BOOTLOADER_FLAG_ADDRESS);

    // Si la bandera solicita entrar al bootloader (0xAA o 0x01)
    if (flag == BOOT_FLAG_UPDATE_REQUESTED || flag == 0x01U)
    {
        result = true;
        
        // Limpiar la bandera para no volver a entrar al bootloader en el próximo reinicio
        NVM_UnlockKeySet(UNLOCK_KEY);
        EEPROM_Write(BOOTLOADER_FLAG_ADDRESS, BOOT_FLAG_NORMAL_BOOT);
        NVM_UnlockKeyClear();
    }

    return result;
}