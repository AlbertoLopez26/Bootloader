subtitle "Microchip MPLAB XC8 C Compiler v3.10 (Free license) build 20250813170317 Og1 "

pagewidth 120

	opt flic

	processor	18F47Q43
include "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc\18f47q43.cgen.inc"
getbyte	macro	val,pos
	(((val) >> (8 * pos)) and 0xff)
endm
byte0	macro	val
	(getbyte(val,0))
endm
byte1	macro	val
	(getbyte(val,1))
endm
byte2	macro	val
	(getbyte(val,2))
endm
byte3	macro	val
	(getbyte(val,3))
endm
byte4	macro	val
	(getbyte(val,4))
endm
byte5	macro	val
	(getbyte(val,5))
endm
byte6	macro	val
	(getbyte(val,6))
endm
byte7	macro	val
	(getbyte(val,7))
endm
getword	macro	val,pos
	(((val) >> (8 * pos)) and 0xffff)
endm
word0	macro	val
	(getword(val,0))
endm
word1	macro	val
	(getword(val,2))
endm
word2	macro	val
	(getword(val,4))
endm
word3	macro	val
	(getword(val,6))
endm
gettword	macro	val,pos
	(((val) >> (8 * pos)) and 0xffffff)
endm
tword0	macro	val
	(gettword(val,0))
endm
tword1	macro	val
	(gettword(val,3))
endm
tword2	macro	val
	(gettword(val,6))
endm
getdword	macro	val,pos
	(((val) >> (8 * pos)) and 0xffffffff)
endm
dword0	macro	val
	(getdword(val,0))
endm
dword1	macro	val
	(getdword(val,4))
endm
clrc   macro
	bcf	status,0
endm
setc   macro
	bsf	status,0
endm
clrz   macro
	bcf	status,2
endm
setz   macro
	bsf	status,2
endm
skipnz macro
	btfsc	status,2
endm
skipz  macro
	btfss	status,2
endm
skipnc macro
	btfsc	status,0
endm
skipc  macro
	btfss	status,0
endm
pushw macro
	movwf postinc1
endm
pushf macro arg1
	movff arg1, postinc1
endm
popw macro
	movf postdec1,f
	movf indf1,w
endm
popf macro arg1
	movf postdec1,f
	movff indf1,arg1
endm
popfc macro arg1
	movff plusw1,arg1
	decfsz fsr1,f
endm
skiprom24 macro arg1
	btfsc arg1,7
endm
	global	__ramtop
	global	__accesstop
# 270 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
CLKRCON equ 039h ;# 
# 374 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
CLKRCLK equ 03Ah ;# 
# 458 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
NVMCON0 equ 040h ;# 
# 502 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
NVMCON1 equ 041h ;# 
# 537 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
NVMLOCK equ 042h ;# 
# 559 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
NVMADR equ 043h ;# 
# 566 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
NVMADRL equ 043h ;# 
# 636 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
NVMADRH equ 044h ;# 
# 706 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
NVMADRU equ 045h ;# 
# 764 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
NVMDAT equ 046h ;# 
# 771 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
NVMDATL equ 046h ;# 
# 841 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
NVMDATH equ 047h ;# 
# 911 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
VREGCON equ 048h ;# 
# 965 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
BORCON equ 049h ;# 
# 992 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
HLVDCON0 equ 04Ah ;# 
# 1072 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
HLVDCON1 equ 04Bh ;# 
# 1144 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
ZCDCON equ 04Ch ;# 
# 1224 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
PMD0 equ 060h ;# 
# 1281 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
PMD1 equ 061h ;# 
# 1343 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
PMD3 equ 063h ;# 
# 1394 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
PMD4 equ 064h ;# 
# 1450 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
PMD5 equ 065h ;# 
# 1501 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
PMD6 equ 066h ;# 
# 1563 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
PMD7 equ 067h ;# 
# 1625 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
PMD8 equ 068h ;# 
# 1675 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
MD1CON0 equ 06Ah ;# 
# 1743 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
MD1CON1 equ 06Bh ;# 
# 1809 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
MD1SRC equ 06Ch ;# 
# 1913 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
MD1CARL equ 06Dh ;# 
# 2005 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
MD1CARH equ 06Eh ;# 
# 2097 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
CMOUT equ 06Fh ;# 
# 2123 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
CM1CON0 equ 070h ;# 
# 2203 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
CM1CON1 equ 071h ;# 
# 2243 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
CM1NCH equ 072h ;# 
# 2303 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
CM1PCH equ 073h ;# 
# 2363 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
CM2CON0 equ 074h ;# 
# 2443 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
CM2CON1 equ 075h ;# 
# 2483 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
CM2NCH equ 076h ;# 
# 2543 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
CM2PCH equ 077h ;# 
# 2603 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
WDTCON0 equ 078h ;# 
# 2714 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
WDTCON1 equ 079h ;# 
# 2834 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
WDTPS equ 07Ah ;# 
# 2841 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
WDTPSL equ 07Ah ;# 
# 2919 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
WDTPSH equ 07Bh ;# 
# 2997 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
WDTTMR equ 07Ch ;# 
# 3094 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
DAC1DAT equ 07Dh ;# 
# 3101 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
DAC1DATL equ 07Dh ;# 
# 3179 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
DAC1CON equ 07Fh ;# 
# 3282 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
SPI1RXB equ 080h ;# 
# 3352 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
SPI1TXB equ 081h ;# 
# 3422 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
SPI1TCNT equ 082h ;# 
# 3429 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
SPI1TCNTL equ 082h ;# 
# 3449 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
SPI1TCNTH equ 083h ;# 
# 3469 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
SPI1CON0 equ 084h ;# 
# 3535 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
SPI1CON1 equ 085h ;# 
# 3637 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
SPI1CON2 equ 086h ;# 
# 3715 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
SPI1STATUS equ 087h ;# 
# 3797 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
SPI1TWIDTH equ 088h ;# 
# 3837 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
SPI1BAUD equ 089h ;# 
# 3907 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
SPI1INTF equ 08Ah ;# 
# 3999 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
SPI1INTE equ 08Bh ;# 
# 4091 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
SPI1CLK equ 08Ch ;# 
# 4183 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
SPI2RXB equ 08Dh ;# 
# 4253 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
SPI2TXB equ 08Eh ;# 
# 4323 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
SPI2TCNT equ 08Fh ;# 
# 4330 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
SPI2TCNTL equ 08Fh ;# 
# 4350 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
SPI2TCNTH equ 090h ;# 
# 4370 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
SPI2CON0 equ 091h ;# 
# 4436 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
SPI2CON1 equ 092h ;# 
# 4538 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
SPI2CON2 equ 093h ;# 
# 4616 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
SPI2STATUS equ 094h ;# 
# 4698 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
SPI2TWIDTH equ 095h ;# 
# 4738 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
SPI2BAUD equ 096h ;# 
# 4808 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
SPI2INTF equ 097h ;# 
# 4900 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
SPI2INTE equ 098h ;# 
# 4992 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
SPI2CLK equ 099h ;# 
# 5084 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
ACTCON equ 0ACh ;# 
# 5154 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
OSCCON1 equ 0ADh ;# 
# 5224 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
OSCCON2 equ 0AEh ;# 
# 5294 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
OSCCON3 equ 0AFh ;# 
# 5334 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
OSCTUNE equ 0B0h ;# 
# 5392 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
OSCFRQ equ 0B1h ;# 
# 5397 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
OSCFREQ equ 0B1h ;# 
# 5482 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
OSCSTAT equ 0B2h ;# 
# 5487 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
OSCSTAT1 equ 0B2h ;# 
# 5594 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
OSCEN equ 0B3h ;# 
# 5651 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
PRLOCK equ 0B4h ;# 
# 5671 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
SCANPR equ 0B5h ;# 
# 5739 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
DMA1PR equ 0B6h ;# 
# 5807 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
DMA2PR equ 0B7h ;# 
# 5875 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
DMA3PR equ 0B8h ;# 
# 5943 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
DMA4PR equ 0B9h ;# 
# 6011 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
DMA5PR equ 0BAh ;# 
# 6079 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
DMA6PR equ 0BBh ;# 
# 6147 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
MAINPR equ 0BEh ;# 
# 6215 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
ISRPR equ 0BFh ;# 
# 6283 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
CLCDATA equ 0D4h ;# 
# 6345 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
CLCSELECT equ 0D5h ;# 
# 6385 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
CLCnCON equ 0D6h ;# 
# 6455 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
CLCnPOL equ 0D7h ;# 
# 6500 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
CLCnSEL0 equ 0D8h ;# 
# 6570 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
CLCnSEL1 equ 0D9h ;# 
# 6640 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
CLCnSEL2 equ 0DAh ;# 
# 6710 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
CLCnSEL3 equ 0DBh ;# 
# 6780 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
CLCnGLS0 equ 0DCh ;# 
# 6842 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
CLCnGLS1 equ 0DDh ;# 
# 6904 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
CLCnGLS2 equ 0DEh ;# 
# 6966 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
CLCnGLS3 equ 0DFh ;# 
# 7028 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
DMASELECT equ 0E8h ;# 
# 7068 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
DMAnBUF equ 0E9h ;# 
# 7138 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
DMAnDCNT equ 0EAh ;# 
# 7145 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
DMAnDCNTL equ 0EAh ;# 
# 7215 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
DMAnDCNTH equ 0EBh ;# 
# 7261 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
DMAnDPTR equ 0ECh ;# 
# 7268 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
DMAnDPTRL equ 0ECh ;# 
# 7338 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
DMAnDPTRH equ 0EDh ;# 
# 7408 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
DMAnDSZ equ 0EEh ;# 
# 7415 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
DMAnDSZL equ 0EEh ;# 
# 7485 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
DMAnDSZH equ 0EFh ;# 
# 7531 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
DMAnDSA equ 0F0h ;# 
# 7538 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
DMAnDSAL equ 0F0h ;# 
# 7608 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
DMAnDSAH equ 0F1h ;# 
# 7678 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
DMAnSCNT equ 0F2h ;# 
# 7685 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
DMAnSCNTL equ 0F2h ;# 
# 7755 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
DMAnSCNTH equ 0F3h ;# 
# 7803 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
DMAnSPTR equ 0F4h ;# 
# 7810 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
DMAnSPTRL equ 0F4h ;# 
# 7880 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
DMAnSPTRH equ 0F5h ;# 
# 7950 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
DMAnSPTRU equ 0F6h ;# 
# 8008 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
DMAnSSZ equ 0F7h ;# 
# 8015 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
DMAnSSZL equ 0F7h ;# 
# 8085 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
DMAnSSZH equ 0F8h ;# 
# 8133 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
DMAnSSA equ 0F9h ;# 
# 8140 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
DMAnSSAL equ 0F9h ;# 
# 8210 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
DMAnSSAH equ 0FAh ;# 
# 8280 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
DMAnSSAU equ 0FBh ;# 
# 8338 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
DMAnCON0 equ 0FCh ;# 
# 8384 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
DMAnCON1 equ 0FDh ;# 
# 8428 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
DMAnAIRQ equ 0FEh ;# 
# 8498 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
DMAnSIRQ equ 0FFh ;# 
# 8568 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
PPSLOCK equ 0200h ;# 
# 8588 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
RA0PPS equ 0201h ;# 
# 8644 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
RA1PPS equ 0202h ;# 
# 8700 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
RA2PPS equ 0203h ;# 
# 8756 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
RA3PPS equ 0204h ;# 
# 8812 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
RA4PPS equ 0205h ;# 
# 8868 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
RA5PPS equ 0206h ;# 
# 8924 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
RA6PPS equ 0207h ;# 
# 8980 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
RA7PPS equ 0208h ;# 
# 9036 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
RB0PPS equ 0209h ;# 
# 9092 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
RB1PPS equ 020Ah ;# 
# 9148 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
RB2PPS equ 020Bh ;# 
# 9204 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
RB3PPS equ 020Ch ;# 
# 9260 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
RB4PPS equ 020Dh ;# 
# 9316 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
RB5PPS equ 020Eh ;# 
# 9372 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
RB6PPS equ 020Fh ;# 
# 9428 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
RB7PPS equ 0210h ;# 
# 9484 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
RC0PPS equ 0211h ;# 
# 9540 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
RC1PPS equ 0212h ;# 
# 9596 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
RC2PPS equ 0213h ;# 
# 9652 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
RC3PPS equ 0214h ;# 
# 9708 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
RC4PPS equ 0215h ;# 
# 9764 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
RC5PPS equ 0216h ;# 
# 9820 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
RC6PPS equ 0217h ;# 
# 9876 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
RC7PPS equ 0218h ;# 
# 9932 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
RD0PPS equ 0219h ;# 
# 9988 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
RD1PPS equ 021Ah ;# 
# 10044 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
RD2PPS equ 021Bh ;# 
# 10100 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
RD3PPS equ 021Ch ;# 
# 10156 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
RD4PPS equ 021Dh ;# 
# 10212 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
RD5PPS equ 021Eh ;# 
# 10268 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
RD6PPS equ 021Fh ;# 
# 10324 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
RD7PPS equ 0220h ;# 
# 10380 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
RE0PPS equ 0221h ;# 
# 10436 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
RE1PPS equ 0222h ;# 
# 10492 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
RE2PPS equ 0223h ;# 
# 10548 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
INT0PPS equ 023Eh ;# 
# 10608 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
INT1PPS equ 023Fh ;# 
# 10674 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
INT2PPS equ 0240h ;# 
# 10746 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
T0CKIPPS equ 0241h ;# 
# 10818 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
T1CKIPPS equ 0242h ;# 
# 10890 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
T1GPPS equ 0243h ;# 
# 10956 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
T3CKIPPS equ 0244h ;# 
# 11028 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
T3GPPS equ 0245h ;# 
# 11094 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
T5CKIPPS equ 0246h ;# 
# 11166 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
T5GPPS equ 0247h ;# 
# 11232 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
T2INPPS equ 0248h ;# 
# 11298 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
T4INPPS equ 0249h ;# 
# 11364 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
T6INPPS equ 024Ah ;# 
# 11430 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
CCP1PPS equ 024Fh ;# 
# 11502 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
CCP2PPS equ 0250h ;# 
# 11574 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
CCP3PPS equ 0251h ;# 
# 11640 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
PWM1ERSPPS equ 0253h ;# 
# 11706 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
PWM2ERSPPS equ 0254h ;# 
# 11778 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
PWM3ERSPPS equ 0255h ;# 
# 11844 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
PWMIN0PPS equ 0257h ;# 
# 11916 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
PWMIN1PPS equ 0258h ;# 
# 11988 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
SMT1WINPPS equ 0259h ;# 
# 12060 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
SMT1SIGPPS equ 025Ah ;# 
# 12132 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
CWG1PPS equ 025Bh ;# 
# 12137 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
CWG1INPPS equ 025Bh ;# 
# 12342 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
CWG2PPS equ 025Ch ;# 
# 12347 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
CWG2INPPS equ 025Ch ;# 
# 12552 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
CWG3PPS equ 025Dh ;# 
# 12557 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
CWG3INPPS equ 025Dh ;# 
# 12762 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
MD1CARLPPS equ 025Eh ;# 
# 12767 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
MDCARLPPS equ 025Eh ;# 
# 12892 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
MD1CARHPPS equ 025Fh ;# 
# 12897 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
MDCARHPPS equ 025Fh ;# 
# 13022 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
MD1SRCPPS equ 0260h ;# 
# 13027 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
MDSRCPPS equ 0260h ;# 
# 13152 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
CLCIN0PPS equ 0261h ;# 
# 13218 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
CLCIN1PPS equ 0262h ;# 
# 13284 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
CLCIN2PPS equ 0263h ;# 
# 13350 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
CLCIN3PPS equ 0264h ;# 
# 13416 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
CLCIN4PPS equ 0265h ;# 
# 13482 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
CLCIN5PPS equ 0266h ;# 
# 13548 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
CLCIN6PPS equ 0267h ;# 
# 13614 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
CLCIN7PPS equ 0268h ;# 
# 13680 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
ADACTPPS equ 0269h ;# 
# 13746 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
SPI1SCKPPS equ 026Ah ;# 
# 13812 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
SPI1SDIPPS equ 026Bh ;# 
# 13878 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
SPI1SSPPS equ 026Ch ;# 
# 13944 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
SPI2SCKPPS equ 026Dh ;# 
# 14010 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
SPI2SDIPPS equ 026Eh ;# 
# 14076 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
SPI2SSPPS equ 026Fh ;# 
# 14142 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
I2C1SDAPPS equ 0270h ;# 
# 14208 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
I2C1SCLPPS equ 0271h ;# 
# 14274 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
U1RXPPS equ 0272h ;# 
# 14346 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
U1CTSPPS equ 0273h ;# 
# 14418 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
U2RXPPS equ 0274h ;# 
# 14484 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
U2CTSPPS equ 0275h ;# 
# 14550 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
U3RXPPS equ 0276h ;# 
# 14622 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
U3CTSPPS equ 0277h ;# 
# 14694 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
U4RXPPS equ 0278h ;# 
# 14760 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
U4CTSPPS equ 0279h ;# 
# 14826 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
U5RXPPS equ 027Ah ;# 
# 14898 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
U5CTSPPS equ 027Bh ;# 
# 14970 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
RC4I2C equ 0286h ;# 
# 15102 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
RC3I2C equ 0287h ;# 
# 15234 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
RB2I2C equ 0288h ;# 
# 15366 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
RB1I2C equ 0289h ;# 
# 15498 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
I2C1RXB equ 028Bh ;# 
# 15518 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
I2C1TXB equ 028Ch ;# 
# 15538 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
I2C1CNT equ 028Dh ;# 
# 15608 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
I2C1ADB0 equ 028Eh ;# 
# 15628 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
I2C1ADB1 equ 028Fh ;# 
# 15648 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
I2C1ADR0 equ 0290h ;# 
# 15668 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
I2C1ADR1 equ 0291h ;# 
# 15689 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
I2C1ADR2 equ 0292h ;# 
# 15709 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
I2C1ADR3 equ 0293h ;# 
# 15730 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
I2C1CON0 equ 0294h ;# 
# 15807 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
I2C1CON1 equ 0295h ;# 
# 15864 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
I2C1CON2 equ 0296h ;# 
# 15940 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
I2C1ERR equ 0297h ;# 
# 16030 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
I2C1STAT0 equ 0298h ;# 
# 16120 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
I2C1STAT1 equ 0299h ;# 
# 16167 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
I2C1PIR equ 029Ah ;# 
# 16269 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
I2C1PIE equ 029Bh ;# 
# 16371 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
I2C1CLK equ 029Ch ;# 
# 16463 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
I2C1BTO equ 029Dh ;# 
# 16543 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
U1RXB equ 02A1h ;# 
# 16548 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
U1RXBL equ 02A1h ;# 
# 16581 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
U1RXCHK equ 02A2h ;# 
# 16601 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
U1TXB equ 02A3h ;# 
# 16606 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
U1TXBL equ 02A3h ;# 
# 16639 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
U1TXCHK equ 02A4h ;# 
# 16659 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
U1P1 equ 02A5h ;# 
# 16666 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
U1P1L equ 02A5h ;# 
# 16686 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
U1P1H equ 02A6h ;# 
# 16706 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
U1P2 equ 02A7h ;# 
# 16713 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
U1P2L equ 02A7h ;# 
# 16733 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
U1P2H equ 02A8h ;# 
# 16753 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
U1P3 equ 02A9h ;# 
# 16760 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
U1P3L equ 02A9h ;# 
# 16780 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
U1P3H equ 02AAh ;# 
# 16800 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
U1CON0 equ 02ABh ;# 
# 16928 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
U1CON1 equ 02ACh ;# 
# 17008 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
U1CON2 equ 02ADh ;# 
# 17150 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
U1BRG equ 02AEh ;# 
# 17157 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
U1BRGL equ 02AEh ;# 
# 17177 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
U1BRGH equ 02AFh ;# 
# 17197 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
U1FIFO equ 02B0h ;# 
# 17327 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
U1UIR equ 02B1h ;# 
# 17383 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
U1ERRIR equ 02B2h ;# 
# 17495 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
U1ERRIE equ 02B3h ;# 
# 17607 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
U2RXB equ 02B4h ;# 
# 17612 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
U2RXBL equ 02B4h ;# 
# 17645 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
U2TXB equ 02B6h ;# 
# 17650 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
U2TXBL equ 02B6h ;# 
# 17683 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
U2P1 equ 02B8h ;# 
# 17690 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
U2P1L equ 02B8h ;# 
# 17710 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
U2P2 equ 02BAh ;# 
# 17717 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
U2P2L equ 02BAh ;# 
# 17737 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
U2P3 equ 02BCh ;# 
# 17744 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
U2P3L equ 02BCh ;# 
# 17764 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
U2CON0 equ 02BEh ;# 
# 17880 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
U2CON1 equ 02BFh ;# 
# 17960 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
U2CON2 equ 02C0h ;# 
# 18092 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
U2BRG equ 02C1h ;# 
# 18099 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
U2BRGL equ 02C1h ;# 
# 18119 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
U2BRGH equ 02C2h ;# 
# 18139 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
U2FIFO equ 02C3h ;# 
# 18269 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
U2UIR equ 02C4h ;# 
# 18325 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
U2ERRIR equ 02C5h ;# 
# 18437 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
U2ERRIE equ 02C6h ;# 
# 18549 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
U3RXB equ 02C7h ;# 
# 18554 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
U3RXBL equ 02C7h ;# 
# 18587 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
U3TXB equ 02C9h ;# 
# 18592 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
U3TXBL equ 02C9h ;# 
# 18625 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
U3P1 equ 02CBh ;# 
# 18632 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
U3P1L equ 02CBh ;# 
# 18652 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
U3P2 equ 02CDh ;# 
# 18659 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
U3P2L equ 02CDh ;# 
# 18679 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
U3P3 equ 02CFh ;# 
# 18686 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
U3P3L equ 02CFh ;# 
# 18706 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
U3CON0 equ 02D1h ;# 
# 18822 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
U3CON1 equ 02D2h ;# 
# 18902 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
U3CON2 equ 02D3h ;# 
# 19034 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
U3BRG equ 02D4h ;# 
# 19041 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
U3BRGL equ 02D4h ;# 
# 19061 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
U3BRGH equ 02D5h ;# 
# 19081 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
U3FIFO equ 02D6h ;# 
# 19211 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
U3UIR equ 02D7h ;# 
# 19267 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
U3ERRIR equ 02D8h ;# 
# 19379 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
U3ERRIE equ 02D9h ;# 
# 19491 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
U4RXB equ 02DAh ;# 
# 19496 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
U4RXBL equ 02DAh ;# 
# 19529 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
U4TXB equ 02DCh ;# 
# 19534 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
U4TXBL equ 02DCh ;# 
# 19567 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
U4P1 equ 02DEh ;# 
# 19574 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
U4P1L equ 02DEh ;# 
# 19594 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
U4P2 equ 02E0h ;# 
# 19601 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
U4P2L equ 02E0h ;# 
# 19621 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
U4P3 equ 02E2h ;# 
# 19628 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
U4P3L equ 02E2h ;# 
# 19648 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
U4CON0 equ 02E4h ;# 
# 19764 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
U4CON1 equ 02E5h ;# 
# 19844 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
U4CON2 equ 02E6h ;# 
# 19976 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
U4BRG equ 02E7h ;# 
# 19983 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
U4BRGL equ 02E7h ;# 
# 20003 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
U4BRGH equ 02E8h ;# 
# 20023 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
U4FIFO equ 02E9h ;# 
# 20153 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
U4UIR equ 02EAh ;# 
# 20209 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
U4ERRIR equ 02EBh ;# 
# 20321 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
U4ERRIE equ 02ECh ;# 
# 20433 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
U5RXB equ 02EDh ;# 
# 20438 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
U5RXBL equ 02EDh ;# 
# 20471 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
U5TXB equ 02EFh ;# 
# 20476 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
U5TXBL equ 02EFh ;# 
# 20509 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
U5P1 equ 02F1h ;# 
# 20516 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
U5P1L equ 02F1h ;# 
# 20536 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
U5P2 equ 02F3h ;# 
# 20543 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
U5P2L equ 02F3h ;# 
# 20563 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
U5P3 equ 02F5h ;# 
# 20570 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
U5P3L equ 02F5h ;# 
# 20590 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
U5CON0 equ 02F7h ;# 
# 20706 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
U5CON1 equ 02F8h ;# 
# 20786 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
U5CON2 equ 02F9h ;# 
# 20918 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
U5BRG equ 02FAh ;# 
# 20925 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
U5BRGL equ 02FAh ;# 
# 20945 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
U5BRGH equ 02FBh ;# 
# 20965 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
U5FIFO equ 02FCh ;# 
# 21095 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
U5UIR equ 02FDh ;# 
# 21151 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
U5ERRIR equ 02FEh ;# 
# 21263 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
U5ERRIE equ 02FFh ;# 
# 21377 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
SMT1TMR equ 0300h ;# 
# 21384 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
SMT1TMRL equ 0300h ;# 
# 21454 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
SMT1TMRH equ 0301h ;# 
# 21524 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
SMT1TMRU equ 0302h ;# 
# 21596 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
SMT1CPR equ 0303h ;# 
# 21603 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
SMT1CPRL equ 0303h ;# 
# 21673 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
SMT1CPRH equ 0304h ;# 
# 21743 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
SMT1CPRU equ 0305h ;# 
# 21815 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
SMT1CPW equ 0306h ;# 
# 21822 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
SMT1CPWL equ 0306h ;# 
# 21892 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
SMT1CPWH equ 0307h ;# 
# 21962 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
SMT1CPWU equ 0308h ;# 
# 22034 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
SMT1PR equ 0309h ;# 
# 22041 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
SMT1PRL equ 0309h ;# 
# 22111 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
SMT1PRH equ 030Ah ;# 
# 22181 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
SMT1PRU equ 030Bh ;# 
# 22251 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
SMT1CON0 equ 030Ch ;# 
# 22316 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
SMT1CON1 equ 030Dh ;# 
# 22416 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
SMT1STAT equ 030Eh ;# 
# 22506 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
SMT1CLK equ 030Fh ;# 
# 22586 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
SMT1SIG equ 0310h ;# 
# 22690 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
SMT1WIN equ 0311h ;# 
# 22794 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
TMR0L equ 0318h ;# 
# 22799 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
TMR0 equ 0318h ;# 
# 22932 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
TMR0H equ 0319h ;# 
# 22937 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
PR0 equ 0319h ;# 
# 23186 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
T0CON0 equ 031Ah ;# 
# 23310 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
T0CON1 equ 031Bh ;# 
# 23452 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
TMR1 equ 031Ch ;# 
# 23459 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
TMR1L equ 031Ch ;# 
# 23579 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
TMR1H equ 031Dh ;# 
# 23699 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
T1CON equ 031Eh ;# 
# 23704 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
TMR1CON equ 031Eh ;# 
# 23921 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
T1GCON equ 031Fh ;# 
# 23926 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
TMR1GCON equ 031Fh ;# 
# 24207 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
T1GATE equ 0320h ;# 
# 24212 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
TMR1GATE equ 0320h ;# 
# 24397 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
T1CLK equ 0321h ;# 
# 24402 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
TMR1CLK equ 0321h ;# 
# 24406 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
PR1 equ 0321h ;# 
# 24643 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
T2TMR equ 0322h ;# 
# 24648 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
TMR2 equ 0322h ;# 
# 24681 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
T2PR equ 0323h ;# 
# 24686 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
PR2 equ 0323h ;# 
# 24719 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
T2CON equ 0324h ;# 
# 24865 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
T2HLT equ 0325h ;# 
# 24993 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
T2CLKCON equ 0326h ;# 
# 24998 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
T2CLK equ 0326h ;# 
# 25199 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
T2RST equ 0327h ;# 
# 25315 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
TMR3 equ 0328h ;# 
# 25322 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
TMR3L equ 0328h ;# 
# 25442 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
TMR3H equ 0329h ;# 
# 25562 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
T3CON equ 032Ah ;# 
# 25567 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
TMR3CON equ 032Ah ;# 
# 25784 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
T3GCON equ 032Bh ;# 
# 25789 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
TMR3GCON equ 032Bh ;# 
# 26070 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
T3GATE equ 032Ch ;# 
# 26075 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
TMR3GATE equ 032Ch ;# 
# 26260 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
T3CLK equ 032Dh ;# 
# 26265 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
TMR3CLK equ 032Dh ;# 
# 26269 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
PR3 equ 032Dh ;# 
# 26506 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
T4TMR equ 032Eh ;# 
# 26511 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
TMR4 equ 032Eh ;# 
# 26544 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
T4PR equ 032Fh ;# 
# 26549 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
PR4 equ 032Fh ;# 
# 26582 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
T4CON equ 0330h ;# 
# 26728 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
T4HLT equ 0331h ;# 
# 26856 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
T4CLKCON equ 0332h ;# 
# 26861 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
T4CLK equ 0332h ;# 
# 27062 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
T4RST equ 0333h ;# 
# 27178 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
TMR5 equ 0334h ;# 
# 27185 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
TMR5L equ 0334h ;# 
# 27305 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
TMR5H equ 0335h ;# 
# 27425 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
T5CON equ 0336h ;# 
# 27430 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
TMR5CON equ 0336h ;# 
# 27647 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
T5GCON equ 0337h ;# 
# 27652 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
TMR5GCON equ 0337h ;# 
# 27933 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
T5GATE equ 0338h ;# 
# 27938 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
TMR5GATE equ 0338h ;# 
# 28123 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
T5CLK equ 0339h ;# 
# 28128 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
TMR5CLK equ 0339h ;# 
# 28132 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
PR5 equ 0339h ;# 
# 28369 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
T6TMR equ 033Ah ;# 
# 28374 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
TMR6 equ 033Ah ;# 
# 28407 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
T6PR equ 033Bh ;# 
# 28412 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
PR6 equ 033Bh ;# 
# 28445 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
T6CON equ 033Ch ;# 
# 28591 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
T6HLT equ 033Dh ;# 
# 28719 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
T6CLKCON equ 033Eh ;# 
# 28724 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
T6CLK equ 033Eh ;# 
# 28925 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
T6RST equ 033Fh ;# 
# 29041 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
CCPR1 equ 0340h ;# 
# 29048 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
CCPR1L equ 0340h ;# 
# 29068 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
CCPR1H equ 0341h ;# 
# 29088 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
CCP1CON equ 0342h ;# 
# 29206 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
CCP1CAP equ 0343h ;# 
# 29286 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
CCPR2 equ 0344h ;# 
# 29293 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
CCPR2L equ 0344h ;# 
# 29313 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
CCPR2H equ 0345h ;# 
# 29333 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
CCP2CON equ 0346h ;# 
# 29451 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
CCP2CAP equ 0347h ;# 
# 29531 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
CCPR3 equ 0348h ;# 
# 29538 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
CCPR3L equ 0348h ;# 
# 29558 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
CCPR3H equ 0349h ;# 
# 29578 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
CCP3CON equ 034Ah ;# 
# 29696 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
CCP3CAP equ 034Bh ;# 
# 29776 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
CCPTMRS0 equ 034Ch ;# 
# 29846 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
CRCDATA equ 034Fh ;# 
# 29853 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
CRCDATL equ 034Fh ;# 
# 29915 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
CRCDATH equ 0350h ;# 
# 29977 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
CRCACC equ 0351h ;# 
# 29984 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
CRCACCL equ 0351h ;# 
# 30046 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
CRCACCH equ 0352h ;# 
# 30108 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
CRCSHFT equ 0353h ;# 
# 30115 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
CRCSHIFTL equ 0353h ;# 
# 30177 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
CRCSHIFTH equ 0354h ;# 
# 30239 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
CRCXOR equ 0355h ;# 
# 30246 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
CRCXORL equ 0355h ;# 
# 30303 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
CRCXORH equ 0356h ;# 
# 30365 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
CRCCON0 equ 0357h ;# 
# 30425 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
CRCCON1 equ 0358h ;# 
# 30503 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
SCANLADR equ 035Ah ;# 
# 30510 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
SCANLADRL equ 035Ah ;# 
# 30638 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
SCANLADRH equ 035Bh ;# 
# 30766 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
SCANLADRU equ 035Ch ;# 
# 30872 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
SCANHADR equ 035Dh ;# 
# 30879 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
SCANHADRL equ 035Dh ;# 
# 31007 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
SCANHADRH equ 035Eh ;# 
# 31135 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
SCANHADRU equ 035Fh ;# 
# 31239 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
SCANCON0 equ 0360h ;# 
# 31299 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
SCANTRIG equ 0361h ;# 
# 31359 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
IPR0 equ 0362h ;# 
# 31411 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
IPR1 equ 0363h ;# 
# 31473 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
IPR2 equ 0364h ;# 
# 31518 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
IPR3 equ 0365h ;# 
# 31580 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
IPR4 equ 0366h ;# 
# 31631 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
IPR5 equ 0367h ;# 
# 31688 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
IPR6 equ 0368h ;# 
# 31750 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
IPR7 equ 0369h ;# 
# 31807 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
IPR8 equ 036Ah ;# 
# 31869 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
IPR9 equ 036Bh ;# 
# 31914 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
IPR10 equ 036Ch ;# 
# 31976 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
IPR11 equ 036Dh ;# 
# 32038 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
IPR12 equ 036Eh ;# 
# 32100 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
IPR13 equ 036Fh ;# 
# 32162 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
IPR14 equ 0370h ;# 
# 32195 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
IPR15 equ 0371h ;# 
# 32233 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
STATUS_CSHAD equ 0373h ;# 
# 32322 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
WREG_CSHAD equ 0374h ;# 
# 32342 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
BSR_CSHAD equ 0375h ;# 
# 32349 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
SHADCON equ 0376h ;# 
# 32369 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
STATUS_SHAD equ 0377h ;# 
# 32458 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
WREG_SHAD equ 0378h ;# 
# 32478 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
BSR_SHAD equ 0379h ;# 
# 32485 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
PCLATH_SHAD equ 037Ah ;# 
# 32505 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
PCLATU_SHAD equ 037Bh ;# 
# 32525 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
FSR0SH equ 037Ch ;# 
# 32532 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
FSR0L_SHAD equ 037Ch ;# 
# 32552 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
FSR0H_SHAD equ 037Dh ;# 
# 32572 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
FSR1SH equ 037Eh ;# 
# 32579 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
FSR1L_SHAD equ 037Eh ;# 
# 32599 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
FSR1H_SHAD equ 037Fh ;# 
# 32619 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
FSR2SH equ 0380h ;# 
# 32626 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
FSR2L_SHAD equ 0380h ;# 
# 32646 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
FSR2H_SHAD equ 0381h ;# 
# 32666 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
PRODSH equ 0382h ;# 
# 32673 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
PRODL_SHAD equ 0382h ;# 
# 32693 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
PRODH_SHAD equ 0383h ;# 
# 32713 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
CWG1CLK equ 03BCh ;# 
# 32718 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
CWG1CLKCON equ 03BCh ;# 
# 32767 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
CWG1ISM equ 03BDh ;# 
# 32772 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
CWG1DAT equ 03BDh ;# 
# 32885 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
CWG1DBR equ 03BEh ;# 
# 32989 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
CWG1DBF equ 03BFh ;# 
# 33093 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
CWG1CON0 equ 03C0h ;# 
# 33194 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
CWG1CON1 equ 03C1h ;# 
# 33272 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
CWG1AS0 equ 03C2h ;# 
# 33434 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
CWG1AS1 equ 03C3h ;# 
# 33496 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
CWG1STR equ 03C4h ;# 
# 33608 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
CWG2CLK equ 03C5h ;# 
# 33613 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
CWG2CLKCON equ 03C5h ;# 
# 33662 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
CWG2ISM equ 03C6h ;# 
# 33667 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
CWG2DAT equ 03C6h ;# 
# 33780 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
CWG2DBR equ 03C7h ;# 
# 33884 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
CWG2DBF equ 03C8h ;# 
# 33988 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
CWG2CON0 equ 03C9h ;# 
# 34089 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
CWG2CON1 equ 03CAh ;# 
# 34167 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
CWG2AS0 equ 03CBh ;# 
# 34329 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
CWG2AS1 equ 03CCh ;# 
# 34391 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
CWG2STR equ 03CDh ;# 
# 34503 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
CWG3CLK equ 03CEh ;# 
# 34508 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
CWG3CLKCON equ 03CEh ;# 
# 34557 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
CWG3ISM equ 03CFh ;# 
# 34562 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
CWG3DAT equ 03CFh ;# 
# 34675 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
CWG3DBR equ 03D0h ;# 
# 34779 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
CWG3DBF equ 03D1h ;# 
# 34883 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
CWG3CON0 equ 03D2h ;# 
# 34984 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
CWG3CON1 equ 03D3h ;# 
# 35062 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
CWG3AS0 equ 03D4h ;# 
# 35224 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
CWG3AS1 equ 03D5h ;# 
# 35286 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
CWG3STR equ 03D6h ;# 
# 35398 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
FVRCON equ 03D7h ;# 
# 35487 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
ADCPCON equ 03D8h ;# 
# 35492 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
ADCP equ 03D8h ;# 
# 35587 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
ADLTH equ 03D9h ;# 
# 35594 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
ADLTHL equ 03D9h ;# 
# 35722 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
ADLTHH equ 03DAh ;# 
# 35850 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
ADUTH equ 03DBh ;# 
# 35857 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
ADUTHL equ 03DBh ;# 
# 35985 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
ADUTHH equ 03DCh ;# 
# 36113 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
ADERR equ 03DDh ;# 
# 36120 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
ADERRL equ 03DDh ;# 
# 36248 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
ADERRH equ 03DEh ;# 
# 36376 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
ADSTPT equ 03DFh ;# 
# 36383 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
ADSTPTL equ 03DFh ;# 
# 36511 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
ADSTPTH equ 03E0h ;# 
# 36639 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
ADFLTR equ 03E1h ;# 
# 36646 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
ADFLTRL equ 03E1h ;# 
# 36774 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
ADFLTRH equ 03E2h ;# 
# 36904 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
ADACC equ 03E3h ;# 
# 36911 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
ADACCL equ 03E3h ;# 
# 37039 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
ADACCH equ 03E4h ;# 
# 37167 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
ADACCU equ 03E5h ;# 
# 37295 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
ADCNT equ 03E6h ;# 
# 37423 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
ADRPT equ 03E7h ;# 
# 37551 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
ADPREV equ 03E8h ;# 
# 37558 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
ADPREVL equ 03E8h ;# 
# 37686 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
ADPREVH equ 03E9h ;# 
# 37814 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
ADRES equ 03EAh ;# 
# 37821 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
ADRESL equ 03EAh ;# 
# 37949 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
ADRESH equ 03EBh ;# 
# 38069 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
ADPCH equ 03ECh ;# 
# 38127 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
ADACQ equ 03EEh ;# 
# 38134 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
ADACQL equ 03EEh ;# 
# 38262 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
ADACQH equ 03EFh ;# 
# 38354 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
ADCAP equ 03F0h ;# 
# 38406 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
ADPRE equ 03F1h ;# 
# 38413 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
ADPREL equ 03F1h ;# 
# 38541 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
ADPREH equ 03F2h ;# 
# 38633 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
ADCON0 equ 03F3h ;# 
# 38751 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
ADCON1 equ 03F4h ;# 
# 38817 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
ADCON2 equ 03F5h ;# 
# 38959 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
ADCON3 equ 03F6h ;# 
# 39089 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
ADSTAT equ 03F7h ;# 
# 39221 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
ADREF equ 03F8h ;# 
# 39303 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
ADACT equ 03F9h ;# 
# 39407 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
ADCLK equ 03FAh ;# 
# 39511 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
ANSELA equ 0400h ;# 
# 39573 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
WPUA equ 0401h ;# 
# 39635 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
ODCONA equ 0402h ;# 
# 39697 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
SLRCONA equ 0403h ;# 
# 39759 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
INLVLA equ 0404h ;# 
# 39821 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
IOCAP equ 0405h ;# 
# 39883 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
IOCAN equ 0406h ;# 
# 39945 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
IOCAF equ 0407h ;# 
# 40007 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
ANSELB equ 0408h ;# 
# 40069 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
WPUB equ 0409h ;# 
# 40131 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
ODCONB equ 040Ah ;# 
# 40193 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
SLRCONB equ 040Bh ;# 
# 40255 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
INLVLB equ 040Ch ;# 
# 40317 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
IOCBP equ 040Dh ;# 
# 40379 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
IOCBN equ 040Eh ;# 
# 40441 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
IOCBF equ 040Fh ;# 
# 40503 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
ANSELC equ 0410h ;# 
# 40565 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
WPUC equ 0411h ;# 
# 40627 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
ODCONC equ 0412h ;# 
# 40689 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
SLRCONC equ 0413h ;# 
# 40751 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
INLVLC equ 0414h ;# 
# 40813 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
IOCCP equ 0415h ;# 
# 40875 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
IOCCN equ 0416h ;# 
# 40937 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
IOCCF equ 0417h ;# 
# 40999 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
ANSELD equ 0418h ;# 
# 41061 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
WPUD equ 0419h ;# 
# 41123 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
ODCOND equ 041Ah ;# 
# 41185 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
SLRCOND equ 041Bh ;# 
# 41247 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
INLVLD equ 041Ch ;# 
# 41309 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
ANSELE equ 0420h ;# 
# 41341 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
WPUE equ 0421h ;# 
# 41379 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
ODCONE equ 0422h ;# 
# 41411 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
SLRCONE equ 0423h ;# 
# 41443 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
INLVLE equ 0424h ;# 
# 41481 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
IOCEP equ 0425h ;# 
# 41502 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
IOCEN equ 0426h ;# 
# 41523 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
IOCEF equ 0427h ;# 
# 41546 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
NCO1ACC equ 0440h ;# 
# 41553 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
NCO1ACCL equ 0440h ;# 
# 41681 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
NCO1ACCH equ 0441h ;# 
# 41809 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
NCO1ACCU equ 0442h ;# 
# 41891 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
NCO1INC equ 0443h ;# 
# 41898 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
NCO1INCL equ 0443h ;# 
# 42026 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
NCO1INCH equ 0444h ;# 
# 42154 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
NCO1INCU equ 0445h ;# 
# 42234 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
NCO1CON equ 0446h ;# 
# 42302 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
NCO1CLK equ 0447h ;# 
# 42444 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
NCO2ACC equ 0448h ;# 
# 42451 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
NCO2ACCL equ 0448h ;# 
# 42579 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
NCO2ACCH equ 0449h ;# 
# 42707 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
NCO2ACCU equ 044Ah ;# 
# 42789 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
NCO2INC equ 044Bh ;# 
# 42796 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
NCO2INCL equ 044Bh ;# 
# 42924 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
NCO2INCH equ 044Ch ;# 
# 43052 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
NCO2INCU equ 044Dh ;# 
# 43132 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
NCO2CON equ 044Eh ;# 
# 43200 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
NCO2CLK equ 044Fh ;# 
# 43342 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
NCO3ACC equ 0450h ;# 
# 43349 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
NCO3ACCL equ 0450h ;# 
# 43477 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
NCO3ACCH equ 0451h ;# 
# 43605 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
NCO3ACCU equ 0452h ;# 
# 43687 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
NCO3INC equ 0453h ;# 
# 43694 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
NCO3INCL equ 0453h ;# 
# 43822 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
NCO3INCH equ 0454h ;# 
# 43950 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
NCO3INCU equ 0455h ;# 
# 44030 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
NCO3CON equ 0456h ;# 
# 44098 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
NCO3CLK equ 0457h ;# 
# 44238 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
IVTLOCK equ 0459h ;# 
# 44260 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
IVTAD equ 045Ah ;# 
# 44267 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
IVTADL equ 045Ah ;# 
# 44329 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
IVTADH equ 045Bh ;# 
# 44391 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
IVTADU equ 045Ch ;# 
# 44437 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
IVTBASE equ 045Dh ;# 
# 44444 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
IVTBASEL equ 045Dh ;# 
# 44506 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
IVTBASEH equ 045Eh ;# 
# 44568 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
IVTBASEU equ 045Fh ;# 
# 44612 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
PWM1ERS equ 0460h ;# 
# 44682 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
PWM1CLK equ 0461h ;# 
# 44752 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
PWM1LDS equ 0462h ;# 
# 44822 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
PWM1PR equ 0463h ;# 
# 44829 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
PWM1PRL equ 0463h ;# 
# 44849 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
PWM1PRH equ 0464h ;# 
# 44869 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
PWM1CPRE equ 0465h ;# 
# 44889 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
PWM1PIPOS equ 0466h ;# 
# 44909 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
PWM1GIR equ 0467h ;# 
# 44935 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
PWM1GIE equ 0468h ;# 
# 44961 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
PWM1CON equ 0469h ;# 
# 45000 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
PWM1S1CFG equ 046Ah ;# 
# 45059 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
PWM1S1P1 equ 046Bh ;# 
# 45066 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
PWM1S1P1L equ 046Bh ;# 
# 45086 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
PWM1S1P1H equ 046Ch ;# 
# 45106 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
PWM1S1P2 equ 046Dh ;# 
# 45113 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
PWM1S1P2L equ 046Dh ;# 
# 45133 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
PWM1S1P2H equ 046Eh ;# 
# 45153 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
PWM2ERS equ 046Fh ;# 
# 45223 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
PWM2CLK equ 0470h ;# 
# 45293 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
PWM2LDS equ 0471h ;# 
# 45363 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
PWM2PR equ 0472h ;# 
# 45370 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
PWM2PRL equ 0472h ;# 
# 45390 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
PWM2PRH equ 0473h ;# 
# 45410 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
PWM2CPRE equ 0474h ;# 
# 45430 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
PWM2PIPOS equ 0475h ;# 
# 45450 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
PWM2GIR equ 0476h ;# 
# 45476 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
PWM2GIE equ 0477h ;# 
# 45502 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
PWM2CON equ 0478h ;# 
# 45541 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
PWM2S1CFG equ 0479h ;# 
# 45600 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
PWM2S1P1 equ 047Ah ;# 
# 45607 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
PWM2S1P1L equ 047Ah ;# 
# 45627 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
PWM2S1P1H equ 047Bh ;# 
# 45647 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
PWM2S1P2 equ 047Ch ;# 
# 45654 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
PWM2S1P2L equ 047Ch ;# 
# 45674 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
PWM2S1P2H equ 047Dh ;# 
# 45694 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
PWM3ERS equ 047Eh ;# 
# 45764 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
PWM3CLK equ 047Fh ;# 
# 45834 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
PWM3LDS equ 0480h ;# 
# 45904 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
PWM3PR equ 0481h ;# 
# 45911 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
PWM3PRL equ 0481h ;# 
# 45931 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
PWM3PRH equ 0482h ;# 
# 45951 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
PWM3CPRE equ 0483h ;# 
# 45971 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
PWM3PIPOS equ 0484h ;# 
# 45991 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
PWM3GIR equ 0485h ;# 
# 46017 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
PWM3GIE equ 0486h ;# 
# 46043 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
PWM3CON equ 0487h ;# 
# 46082 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
PWM3S1CFG equ 0488h ;# 
# 46141 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
PWM3S1P1 equ 0489h ;# 
# 46148 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
PWM3S1P1L equ 0489h ;# 
# 46168 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
PWM3S1P1H equ 048Ah ;# 
# 46188 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
PWM3S1P2 equ 048Bh ;# 
# 46195 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
PWM3S1P2L equ 048Bh ;# 
# 46215 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
PWM3S1P2H equ 048Ch ;# 
# 46235 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
PWMLOAD equ 049Ch ;# 
# 46267 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
PWMEN equ 049Dh ;# 
# 46299 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
PIE0 equ 049Eh ;# 
# 46351 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
PIE1 equ 049Fh ;# 
# 46413 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
PIE2 equ 04A0h ;# 
# 46458 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
PIE3 equ 04A1h ;# 
# 46520 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
PIE4 equ 04A2h ;# 
# 46571 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
PIE5 equ 04A3h ;# 
# 46628 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
PIE6 equ 04A4h ;# 
# 46690 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
PIE7 equ 04A5h ;# 
# 46747 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
PIE8 equ 04A6h ;# 
# 46809 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
PIE9 equ 04A7h ;# 
# 46854 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
PIE10 equ 04A8h ;# 
# 46916 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
PIE11 equ 04A9h ;# 
# 46978 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
PIE12 equ 04AAh ;# 
# 47040 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
PIE13 equ 04ABh ;# 
# 47102 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
PIE14 equ 04ACh ;# 
# 47135 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
PIE15 equ 04ADh ;# 
# 47173 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
PIR0 equ 04AEh ;# 
# 47225 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
PIR1 equ 04AFh ;# 
# 47287 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
PIR2 equ 04B0h ;# 
# 47332 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
PIR3 equ 04B1h ;# 
# 47394 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
PIR4 equ 04B2h ;# 
# 47445 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
PIR5 equ 04B3h ;# 
# 47502 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
PIR6 equ 04B4h ;# 
# 47564 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
PIR7 equ 04B5h ;# 
# 47621 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
PIR8 equ 04B6h ;# 
# 47683 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
PIR9 equ 04B7h ;# 
# 47728 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
PIR10 equ 04B8h ;# 
# 47790 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
PIR11 equ 04B9h ;# 
# 47852 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
PIR12 equ 04BAh ;# 
# 47914 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
PIR13 equ 04BBh ;# 
# 47976 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
PIR14 equ 04BCh ;# 
# 48009 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
PIR15 equ 04BDh ;# 
# 48047 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
LATA equ 04BEh ;# 
# 48109 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
LATB equ 04BFh ;# 
# 48171 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
LATC equ 04C0h ;# 
# 48233 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
LATD equ 04C1h ;# 
# 48295 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
LATE equ 04C2h ;# 
# 48327 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
TRISA equ 04C6h ;# 
# 48389 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
TRISB equ 04C7h ;# 
# 48451 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
TRISC equ 04C8h ;# 
# 48513 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
TRISD equ 04C9h ;# 
# 48575 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
TRISE equ 04CAh ;# 
# 48607 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
PORTA equ 04CEh ;# 
# 48669 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
PORTB equ 04CFh ;# 
# 48731 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
PORTC equ 04D0h ;# 
# 48793 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
PORTD equ 04D1h ;# 
# 48855 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
PORTE equ 04D2h ;# 
# 48893 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
INTCON0 equ 04D6h ;# 
# 48953 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
INTCON1 equ 04D7h ;# 
# 48989 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
STATUS equ 04D8h ;# 
# 49078 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
FSR2 equ 04D9h ;# 
# 49085 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
FSR2L equ 04D9h ;# 
# 49105 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
FSR2H equ 04DAh ;# 
# 49112 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
PLUSW2 equ 04DBh ;# 
# 49132 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
PREINC2 equ 04DCh ;# 
# 49152 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
POSTDEC2 equ 04DDh ;# 
# 49172 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
POSTINC2 equ 04DEh ;# 
# 49192 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
INDF2 equ 04DFh ;# 
# 49212 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
BSR equ 04E0h ;# 
# 49219 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
FSR1 equ 04E1h ;# 
# 49226 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
FSR1L equ 04E1h ;# 
# 49246 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
FSR1H equ 04E2h ;# 
# 49253 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
PLUSW1 equ 04E3h ;# 
# 49273 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
PREINC1 equ 04E4h ;# 
# 49293 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
POSTDEC1 equ 04E5h ;# 
# 49313 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
POSTINC1 equ 04E6h ;# 
# 49333 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
INDF1 equ 04E7h ;# 
# 49353 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
WREG equ 04E8h ;# 
# 49391 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
FSR0 equ 04E9h ;# 
# 49398 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
FSR0L equ 04E9h ;# 
# 49418 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
FSR0H equ 04EAh ;# 
# 49425 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
PLUSW0 equ 04EBh ;# 
# 49445 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
PREINC0 equ 04ECh ;# 
# 49465 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
POSTDEC0 equ 04EDh ;# 
# 49485 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
POSTINC0 equ 04EEh ;# 
# 49505 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
INDF0 equ 04EFh ;# 
# 49525 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
PCON0 equ 04F0h ;# 
# 49678 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
PCON1 equ 04F1h ;# 
# 49745 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
CPUDOZE equ 04F2h ;# 
# 49810 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
PROD equ 04F3h ;# 
# 49817 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
PRODL equ 04F3h ;# 
# 49837 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
PRODH equ 04F4h ;# 
# 49857 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
TABLAT equ 04F5h ;# 
# 49879 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
TBLPTR equ 04F6h ;# 
# 49886 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
TBLPTRL equ 04F6h ;# 
# 49906 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
TBLPTRH equ 04F7h ;# 
# 49926 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
TBLPTRU equ 04F8h ;# 
# 49957 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
PCLAT equ 04F9h ;# 
# 49964 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
PCL equ 04F9h ;# 
# 49984 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
PCLATH equ 04FAh ;# 
# 50004 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
PCLATU equ 04FBh ;# 
# 50024 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
STKPTR equ 04FCh ;# 
# 50122 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
TOS equ 04FDh ;# 
# 50129 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
TOSL equ 04FDh ;# 
# 50149 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
TOSH equ 04FEh ;# 
# 50169 "C:\Program Files\Microchip\MPLABX\v6.30\packs\Microchip\PIC18F-Q_DFP\1.28.451\xc8\pic\include\proc/pic18f47q43.h"
TOSU equ 04FFh ;# 
	debug_source C
	FNCALL	_main,_ClockInitialize
	FNCALL	_main,_DelayMsWithCommand
	FNCALL	_main,_PinsInitialize
	FNCALL	_main,_UartInitialize
	FNCALL	_DelayMsWithCommand,_XBeeCommandTask
	FNCALL	_XBeeCommandTask,_RequestBootloader
	FNCALL	_XBeeCommandTask,_XBeePayloadIsBootCommand
	FNCALL	_RequestBootloader,_EepromWriteByte
	FNROOT	_main
	global	XBeeCommandTask@bytesRead
	global	XBeeCommandTask@xbeeLen
	global	XBeeCommandTask@discardFrame
	global	XBeeCommandTask@payloadLength
	global	XBeeCommandTask@payloadIndex
	global	XBeeCommandTask@checksum
	global	XBeeCommandTask@state
	global	_unlockKeyLow
	global	_unlockKeyHigh
	global	XBeeCommandTask@payload
	global	_NVMCON0bits
_NVMCON0bits	set	0x40
	global	_NVMLOCK
_NVMLOCK	set	0x42
	global	_NVMCON1bits
_NVMCON1bits	set	0x41
	global	_NVMDATL
_NVMDATL	set	0x46
	global	_NVMADRL
_NVMADRL	set	0x43
	global	_NVMADRH
_NVMADRH	set	0x44
	global	_NVMADRU
_NVMADRU	set	0x45
	global	_ACTCON
_ACTCON	set	0xAC
	global	_OSCTUNE
_OSCTUNE	set	0xB0
	global	_OSCFRQ
_OSCFRQ	set	0xB1
	global	_OSCEN
_OSCEN	set	0xB3
	global	_OSCCON3
_OSCCON3	set	0xAF
	global	_OSCCON1
_OSCCON1	set	0xAD
	global	_U1FIFObits
_U1FIFObits	set	0x2B0
	global	_U1RXB
_U1RXB	set	0x2A1
	global	_U1ERRIRbits
_U1ERRIRbits	set	0x2B2
	global	_U1ERRIE
_U1ERRIE	set	0x2B3
	global	_U1ERRIR
_U1ERRIR	set	0x2B2
	global	_U1UIR
_U1UIR	set	0x2B1
	global	_U1FIFO
_U1FIFO	set	0x2B0
	global	_U1BRGH
_U1BRGH	set	0x2AF
	global	_U1BRGL
_U1BRGL	set	0x2AE
	global	_U1CON2
_U1CON2	set	0x2AD
	global	_U1CON1
_U1CON1	set	0x2AC
	global	_U1CON0
_U1CON0	set	0x2AB
	global	_U1P3H
_U1P3H	set	0x2AA
	global	_U1P3L
_U1P3L	set	0x2A9
	global	_U1P2H
_U1P2H	set	0x2A8
	global	_U1P2L
_U1P2L	set	0x2A7
	global	_U1P1H
_U1P1H	set	0x2A6
	global	_U1P1L
_U1P1L	set	0x2A5
	global	_U1TXCHK
_U1TXCHK	set	0x2A4
	global	_U1RXCHK
_U1RXCHK	set	0x2A2
	global	_RC6PPS
_RC6PPS	set	0x217
	global	_U1RXPPS
_U1RXPPS	set	0x272
	global	_INLVLE
_INLVLE	set	0x424
	global	_INLVLD
_INLVLD	set	0x41C
	global	_INLVLC
_INLVLC	set	0x414
	global	_INLVLB
_INLVLB	set	0x40C
	global	_INLVLA
_INLVLA	set	0x404
	global	_SLRCONE
_SLRCONE	set	0x423
	global	_SLRCOND
_SLRCOND	set	0x41B
	global	_SLRCONC
_SLRCONC	set	0x413
	global	_SLRCONB
_SLRCONB	set	0x40B
	global	_SLRCONA
_SLRCONA	set	0x403
	global	_WPUE
_WPUE	set	0x421
	global	_WPUD
_WPUD	set	0x419
	global	_WPUC
_WPUC	set	0x411
	global	_WPUB
_WPUB	set	0x409
	global	_WPUA
_WPUA	set	0x401
	global	_ODCONE
_ODCONE	set	0x422
	global	_ODCOND
_ODCOND	set	0x41A
	global	_ODCONC
_ODCONC	set	0x412
	global	_ODCONB
_ODCONB	set	0x40A
	global	_ODCONA
_ODCONA	set	0x402
	global	_ANSELE
_ANSELE	set	0x420
	global	_ANSELD
_ANSELD	set	0x418
	global	_ANSELC
_ANSELC	set	0x410
	global	_ANSELB
_ANSELB	set	0x408
	global	_ANSELA
_ANSELA	set	0x400
	global	_LATDbits
_LATDbits	set	0x4C1
	global	_INTCON0bits
_INTCON0bits	set	0x4D6
	global	_TRISE
_TRISE	set	0x4CA
	global	_TRISD
_TRISD	set	0x4C9
	global	_TRISC
_TRISC	set	0x4C8
	global	_TRISB
_TRISB	set	0x4C7
	global	_TRISA
_TRISA	set	0x4C6
	global	_LATE
_LATE	set	0x4C2
	global	_LATD
_LATD	set	0x4C1
	global	_LATC
_LATC	set	0x4C0
	global	_LATB
_LATB	set	0x4BF
	global	_LATA
_LATA	set	0x4BE
; #config settings
	config pad_punits      = on
	config apply_mask      = off
	config ignore_cmsgs    = off
	config default_configs = off
	config default_idlocs  = off
	file	"dist\APP_FAST_BLINK.s"
	line	#
psect	cinit,class=CODE,delta=1,reloc=2
global __pcinit
__pcinit:
global start_initialization
start_initialization:

global __initialization
__initialization:
psect	bssCOMRAM,class=COMRAM,space=1,noexec,lowdata
global __pbssCOMRAM
__pbssCOMRAM:
XBeeCommandTask@bytesRead:
       ds      2
XBeeCommandTask@xbeeLen:
       ds      2
XBeeCommandTask@discardFrame:
       ds      1
XBeeCommandTask@payloadLength:
       ds      1
XBeeCommandTask@payloadIndex:
       ds      1
XBeeCommandTask@checksum:
       ds      1
XBeeCommandTask@state:
       ds      1
_unlockKeyLow:
       ds      1
_unlockKeyHigh:
       ds      1
XBeeCommandTask@payload:
       ds      8
	file	"dist\APP_FAST_BLINK.s"
	line	#
psect	cinit
; Clear objects allocated to COMRAM (19 bytes)
	global __pbssCOMRAM
lfsr	0,__pbssCOMRAM
movlw	19
clear_0:
clrf	postinc0,c
decf	wreg
bnz	clear_0
psect cinit,class=CODE,delta=1
global end_of_initialization,__end_of__initialization

;End of C runtime variable initialization code

end_of_initialization:
__end_of__initialization:
movlb 0
goto _main	;jump to C main() function
psect	cstackCOMRAM,class=COMRAM,space=1,noexec,lowdata
global __pcstackCOMRAM
__pcstackCOMRAM:
?_RequestBootloader:	; 1 bytes @ 0x0
?_ClockInitialize:	; 1 bytes @ 0x0
?_PinsInitialize:	; 1 bytes @ 0x0
?_UartInitialize:	; 1 bytes @ 0x0
?_XBeePayloadIsBootCommand:	; 1 bytes @ 0x0
?_XBeeCommandTask:	; 1 bytes @ 0x0
?_EepromWriteByte:	; 1 bytes @ 0x0
?_main:	; 1 bytes @ 0x0
	global	XBeePayloadIsBootCommand@payload
XBeePayloadIsBootCommand@payload:	; 2 bytes @ 0x0
	global	EepromWriteByte@address
EepromWriteByte@address:	; 4 bytes @ 0x0
??_ClockInitialize:	; 1 bytes @ 0x0
??_PinsInitialize:	; 1 bytes @ 0x0
??_UartInitialize:	; 1 bytes @ 0x0
	ds   2
	global	XBeePayloadIsBootCommand@payloadLength
XBeePayloadIsBootCommand@payloadLength:	; 1 bytes @ 0x2
	ds   1
??_XBeePayloadIsBootCommand:	; 1 bytes @ 0x3
	ds   1
	global	_XBeePayloadIsBootCommand$293
_XBeePayloadIsBootCommand$293:	; 1 bytes @ 0x4
	global	EepromWriteByte@data
EepromWriteByte@data:	; 1 bytes @ 0x4
	ds   1
	global	EepromWriteByte@gieState
EepromWriteByte@gieState:	; 1 bytes @ 0x5
??_EepromWriteByte:	; 1 bytes @ 0x5
	ds   1
	global	XBeeCommandTask@byte
XBeeCommandTask@byte:	; 1 bytes @ 0x6
??_RequestBootloader:	; 1 bytes @ 0x6
??_XBeeCommandTask:	; 1 bytes @ 0x6
	ds   1
?_DelayMsWithCommand:	; 1 bytes @ 0x7
	global	DelayMsWithCommand@delayMs
DelayMsWithCommand@delayMs:	; 2 bytes @ 0x7
	ds   2
??_DelayMsWithCommand:	; 1 bytes @ 0x9
	ds   1
??_main:	; 1 bytes @ 0xA
;!
;!Data Sizes:
;!    Strings     0
;!    Constant    0
;!    Data        0
;!    BSS         19
;!    Persistent  0
;!    Stack       0
;!
;!Auto Spaces:
;!    Space          Size  Autos    Used
;!    COMRAM           95     10      29
;!    BANK5           160      0       0
;!    BANK6           256      0       0
;!    BANK7           256      0       0
;!    BANK8           256      0       0
;!    BANK9           256      0       0
;!    BANK10          256      0       0
;!    BANK11          256      0       0
;!    BANK12          256      0       0
;!    BANK13          256      0       0
;!    BANK14          256      0       0
;!    BANK15          256      0       0
;!    BANK16          256      0       0
;!    BANK17          256      0       0
;!    BANK18          256      0       0
;!    BANK19          256      0       0
;!    BANK20          256      0       0
;!    BANK21          256      0       0
;!    BANK22          256      0       0
;!    BANK23          256      0       0
;!    BANK24          256      0       0
;!    BANK25          256      0       0
;!    BANK26          256      0       0
;!    BANK27          256      0       0
;!    BANK28          256      0       0
;!    BANK29          256      0       0
;!    BANK30          256      0       0
;!    BANK31          256      0       0
;!    BANK32          256      0       0
;!    BANK33          256      0       0
;!    BANK34          256      0       0
;!    BANK35          256      0       0
;!    BANK36          256      0       0

;!
;!Pointer List with Targets:
;!
;!    XBeePayloadIsBootCommand@payload	PTR const unsigned char  size(2) Largest target is 8
;!		 -> XBeeCommandTask@payload(COMRAM[8]), 
;!


;!
;!Critical Paths under _main in COMRAM
;!
;!    _main->_DelayMsWithCommand
;!    _DelayMsWithCommand->_XBeeCommandTask
;!    _RequestBootloader->_EepromWriteByte
;!
;!Critical Paths under _main in BANK5
;!
;!    None.
;!
;!Critical Paths under _main in BANK6
;!
;!    None.
;!
;!Critical Paths under _main in BANK7
;!
;!    None.
;!
;!Critical Paths under _main in BANK8
;!
;!    None.
;!
;!Critical Paths under _main in BANK9
;!
;!    None.
;!
;!Critical Paths under _main in BANK10
;!
;!    None.
;!
;!Critical Paths under _main in BANK11
;!
;!    None.
;!
;!Critical Paths under _main in BANK12
;!
;!    None.
;!
;!Critical Paths under _main in BANK13
;!
;!    None.
;!
;!Critical Paths under _main in BANK14
;!
;!    None.
;!
;!Critical Paths under _main in BANK15
;!
;!    None.
;!
;!Critical Paths under _main in BANK16
;!
;!    None.
;!
;!Critical Paths under _main in BANK17
;!
;!    None.
;!
;!Critical Paths under _main in BANK18
;!
;!    None.
;!
;!Critical Paths under _main in BANK19
;!
;!    None.
;!
;!Critical Paths under _main in BANK20
;!
;!    None.
;!
;!Critical Paths under _main in BANK21
;!
;!    None.
;!
;!Critical Paths under _main in BANK22
;!
;!    None.
;!
;!Critical Paths under _main in BANK23
;!
;!    None.
;!
;!Critical Paths under _main in BANK24
;!
;!    None.
;!
;!Critical Paths under _main in BANK25
;!
;!    None.
;!
;!Critical Paths under _main in BANK26
;!
;!    None.
;!
;!Critical Paths under _main in BANK27
;!
;!    None.
;!
;!Critical Paths under _main in BANK28
;!
;!    None.
;!
;!Critical Paths under _main in BANK29
;!
;!    None.
;!
;!Critical Paths under _main in BANK30
;!
;!    None.
;!
;!Critical Paths under _main in BANK31
;!
;!    None.
;!
;!Critical Paths under _main in BANK32
;!
;!    None.
;!
;!Critical Paths under _main in BANK33
;!
;!    None.
;!
;!Critical Paths under _main in BANK34
;!
;!    None.
;!
;!Critical Paths under _main in BANK35
;!
;!    None.
;!
;!Critical Paths under _main in BANK36
;!
;!    None.

;;
;;Main: autosize = 0, tempsize = 0, incstack = 0, save=0
;;

;!
;!Call Graph Tables:
;!
;! ---------------------------------------------------------------------------------
;! (Depth) Function   	        Calls       Base Space   Used Autos Params    Refs
;! ---------------------------------------------------------------------------------
;! (0) _main                                                 0     0      0     428
;!                    _ClockInitialize
;!                 _DelayMsWithCommand
;!                     _PinsInitialize
;!                     _UartInitialize
;! ---------------------------------------------------------------------------------
;! (1) _UartInitialize                                       0     0      0       0
;! ---------------------------------------------------------------------------------
;! (1) _PinsInitialize                                       0     0      0       0
;! ---------------------------------------------------------------------------------
;! (1) _DelayMsWithCommand                                   3     1      2     428
;!                                              7 COMRAM     3     1      2
;!                    _XBeeCommandTask
;! ---------------------------------------------------------------------------------
;! (2) _XBeeCommandTask                                      1     1      0     404
;!                                              6 COMRAM     1     1      0
;!                  _RequestBootloader
;!           _XBeePayloadIsBootCommand
;! ---------------------------------------------------------------------------------
;! (3) _XBeePayloadIsBootCommand                             5     2      3     136
;!                                              0 COMRAM     5     2      3
;! ---------------------------------------------------------------------------------
;! (3) _RequestBootloader                                    0     0      0     113
;!                    _EepromWriteByte
;! ---------------------------------------------------------------------------------
;! (4) _EepromWriteByte                                      6     1      5     113
;!                                              0 COMRAM     6     1      5
;! ---------------------------------------------------------------------------------
;! (1) _ClockInitialize                                      0     0      0       0
;! ---------------------------------------------------------------------------------
;! Estimated maximum stack depth 4
;! ---------------------------------------------------------------------------------
;!
;! Call Graph Graphs:
;!
;! _main (ROOT)
;!   _ClockInitialize
;!   _DelayMsWithCommand
;!     _XBeeCommandTask
;!       _RequestBootloader
;!         _EepromWriteByte
;!       _XBeePayloadIsBootCommand
;!   _PinsInitialize
;!   _UartInitialize
;!

;!Address spaces:

;!Name               Size   Autos  Total    Usage
;!BIGRAM            8191      0       0      0.0%
;!BITBIGSFRh        1211      0       0      0.0%
;!BITBIGSFR_1        256      0       0      0.0%
;!BITBANK36          256      0       0      0.0%
;!BANK36             256      0       0      0.0%
;!BITBANK35          256      0       0      0.0%
;!BANK35             256      0       0      0.0%
;!BITBANK34          256      0       0      0.0%
;!BANK34             256      0       0      0.0%
;!BITBANK33          256      0       0      0.0%
;!BANK33             256      0       0      0.0%
;!BITBANK32          256      0       0      0.0%
;!BANK32             256      0       0      0.0%
;!BITBANK31          256      0       0      0.0%
;!BANK31             256      0       0      0.0%
;!BITBANK30          256      0       0      0.0%
;!BANK30             256      0       0      0.0%
;!BITBANK29          256      0       0      0.0%
;!BANK29             256      0       0      0.0%
;!BITBANK28          256      0       0      0.0%
;!BANK28             256      0       0      0.0%
;!BITBANK27          256      0       0      0.0%
;!BANK27             256      0       0      0.0%
;!BITBANK26          256      0       0      0.0%
;!BANK26             256      0       0      0.0%
;!BITBANK25          256      0       0      0.0%
;!BANK25             256      0       0      0.0%
;!BITBANK24          256      0       0      0.0%
;!BANK24             256      0       0      0.0%
;!BITBANK23          256      0       0      0.0%
;!BANK23             256      0       0      0.0%
;!BITBANK22          256      0       0      0.0%
;!BANK22             256      0       0      0.0%
;!BITBANK21          256      0       0      0.0%
;!BANK21             256      0       0      0.0%
;!BITBANK20          256      0       0      0.0%
;!BANK20             256      0       0      0.0%
;!BITBANK19          256      0       0      0.0%
;!BANK19             256      0       0      0.0%
;!BITBANK18          256      0       0      0.0%
;!BANK18             256      0       0      0.0%
;!BITBANK17          256      0       0      0.0%
;!BANK17             256      0       0      0.0%
;!BITBANK16          256      0       0      0.0%
;!BANK16             256      0       0      0.0%
;!BITBANK15          256      0       0      0.0%
;!BANK15             256      0       0      0.0%
;!BITBANK14          256      0       0      0.0%
;!BANK14             256      0       0      0.0%
;!BITBANK13          256      0       0      0.0%
;!BANK13             256      0       0      0.0%
;!BITBANK12          256      0       0      0.0%
;!BANK12             256      0       0      0.0%
;!BITBANK11          256      0       0      0.0%
;!BANK11             256      0       0      0.0%
;!BITBANK10          256      0       0      0.0%
;!BANK10             256      0       0      0.0%
;!BITBANK9           256      0       0      0.0%
;!BANK9              256      0       0      0.0%
;!BITBANK8           256      0       0      0.0%
;!BANK8              256      0       0      0.0%
;!BITBANK7           256      0       0      0.0%
;!BANK7              256      0       0      0.0%
;!BITBANK6           256      0       0      0.0%
;!BANK6              256      0       0      0.0%
;!BITBANK5           160      0       0      0.0%
;!BANK5              160      0       0      0.0%
;!BITCOMRAM           95      0       0      0.0%
;!COMRAM              95     10      29     30.5%
;!BITBIGSFRl          64      0       0      0.0%
;!STACK                0      0       0      0.0%
;!DATA                 0      0      29      0.0%

	global	_main

;; *************** function _main *****************
;; Defined at:
;;		line 255 in file "main.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;                  1    wreg      void 
;; Registers used:
;;		wreg, fsr2l, fsr2h, status,2, status,0, cstack
;; Tracked objects:
;;		On entry : 0/0
;;		On exit  : 0/0
;;		Unchanged: 0/0
;; Data sizes:     COMRAM   BANK5   BANK6   BANK7   BANK8   BANK9  BANK10  BANK11  BANK12  BANK13  BANK14  BANK15  BANK16  BANK17  BANK18  BANK19  BANK20  BANK21  BANK22  BANK23  BANK24  BANK25  BANK26  BANK27  BANK28  BANK29  BANK30  BANK31  BANK32  BANK33  BANK34  BANK35  BANK36
;;      Params:         0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0
;;      Locals:         0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0
;;      Temps:          0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0
;;      Totals:         0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0
;;Total ram usage:        0 bytes
;; Hardware stack levels required when called: 4
;; This function calls:
;;		_ClockInitialize
;;		_DelayMsWithCommand
;;		_PinsInitialize
;;		_UartInitialize
;; This function is called by:
;;		Startup code after reset
;; This function uses a non-reentrant model
;;
psect	text0,class=CODE,space=0,reloc=2,group=0
	file	"main.c"
	line	255
global __ptext0
__ptext0:
psect	text0
	file	"main.c"
	line	255
	
_main:
;incstack = 0
	callstack 123
	line	257
	
l1331:
	call	_ClockInitialize	;wreg free
	line	258
	call	_PinsInitialize	;wreg free
	line	259
	call	_UartInitialize	;wreg free
	line	263
	
l1333:
	bcf	((c:1217))^0400h,c,1	;volatile
	line	264
	
l1335:
	clrf	((c:DelayMsWithCommand@delayMs+1))^0500h,c
	movlw	low(064h)
	movwf	((c:DelayMsWithCommand@delayMs))^0500h,c
	call	_DelayMsWithCommand	;wreg free
	line	265
	
l1337:
	bsf	((c:1217))^0400h,c,1	;volatile
	line	266
	
l1339:
	clrf	((c:DelayMsWithCommand@delayMs+1))^0500h,c
	movlw	low(064h)
	movwf	((c:DelayMsWithCommand@delayMs))^0500h,c
	call	_DelayMsWithCommand	;wreg free
	goto	l1333
	global	start
	goto	start
	callstack 0
	line	268
GLOBAL	__end_of_main
	__end_of_main:
	signat	_main,89
	global	_UartInitialize

;; *************** function _UartInitialize *****************
;; Defined at:
;;		line 83 in file "main.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;                  1    wreg      void 
;; Registers used:
;;		wreg, status,2
;; Tracked objects:
;;		On entry : 0/0
;;		On exit  : 0/0
;;		Unchanged: 0/0
;; Data sizes:     COMRAM   BANK5   BANK6   BANK7   BANK8   BANK9  BANK10  BANK11  BANK12  BANK13  BANK14  BANK15  BANK16  BANK17  BANK18  BANK19  BANK20  BANK21  BANK22  BANK23  BANK24  BANK25  BANK26  BANK27  BANK28  BANK29  BANK30  BANK31  BANK32  BANK33  BANK34  BANK35  BANK36
;;      Params:         0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0
;;      Locals:         0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0
;;      Temps:          0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0
;;      Totals:         0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0
;;Total ram usage:        0 bytes
;; Hardware stack levels used: 1
;; This function calls:
;;		Nothing
;; This function is called by:
;;		_main
;; This function uses a non-reentrant model
;;
psect	text1,class=CODE,space=0,reloc=2,group=0
	line	83
global __ptext1
__ptext1:
psect	text1
	file	"main.c"
	line	83
	
_UartInitialize:
;incstack = 0
	callstack 126
	line	85
	
l1189:
	movlb	2	; () banked
	clrf	((674))&0ffh	;volatile
	line	86
	clrf	((676))&0ffh	;volatile
	line	87
	clrf	((677))&0ffh	;volatile
	line	88
	clrf	((678))&0ffh	;volatile
	line	89
	clrf	((679))&0ffh	;volatile
	line	90
	clrf	((680))&0ffh	;volatile
	line	91
	clrf	((681))&0ffh	;volatile
	line	92
	clrf	((682))&0ffh	;volatile
	line	93
	
l1191:; BSR set to: 2

	movlw	low(0B0h)
	movwf	((683))&0ffh	;volatile
	line	94
	movlw	low(080h)
	movwf	((684))&0ffh	;volatile
	line	95
	movlw	low(08h)
	movwf	((685))&0ffh	;volatile
	line	96
	movlw	low(0A0h)
	movwf	((686))&0ffh	;volatile
	line	97
	movlw	low(01h)
	movwf	((687))&0ffh	;volatile
	line	98
	movlw	low(02Eh)
	movwf	((688))&0ffh	;volatile
	line	99
	
l1193:; BSR set to: 2

	clrf	((689))&0ffh	;volatile
	line	100
	movlw	low(080h)
	movwf	((690))&0ffh	;volatile
	line	101
	
l1195:; BSR set to: 2

	clrf	((691))&0ffh	;volatile
	line	102
	
l161:; BSR set to: 2

	return	;funcret
	callstack 0
GLOBAL	__end_of_UartInitialize
	__end_of_UartInitialize:
	signat	_UartInitialize,89
	global	_PinsInitialize

;; *************** function _PinsInitialize *****************
;; Defined at:
;;		line 35 in file "main.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;                  1    wreg      void 
;; Registers used:
;;		wreg, status,2
;; Tracked objects:
;;		On entry : 0/0
;;		On exit  : 0/0
;;		Unchanged: 0/0
;; Data sizes:     COMRAM   BANK5   BANK6   BANK7   BANK8   BANK9  BANK10  BANK11  BANK12  BANK13  BANK14  BANK15  BANK16  BANK17  BANK18  BANK19  BANK20  BANK21  BANK22  BANK23  BANK24  BANK25  BANK26  BANK27  BANK28  BANK29  BANK30  BANK31  BANK32  BANK33  BANK34  BANK35  BANK36
;;      Params:         0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0
;;      Locals:         0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0
;;      Temps:          0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0
;;      Totals:         0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0
;;Total ram usage:        0 bytes
;; Hardware stack levels used: 1
;; This function calls:
;;		Nothing
;; This function is called by:
;;		_main
;; This function uses a non-reentrant model
;;
psect	text2,class=CODE,space=0,reloc=2,group=0
	line	35
global __ptext2
__ptext2:
psect	text2
	file	"main.c"
	line	35
	
_PinsInitialize:; BSR set to: 2

;incstack = 0
	callstack 126
	line	37
	
l1139:
	clrf	((c:1214))^0400h,c	;volatile
	line	38
	clrf	((c:1215))^0400h,c	;volatile
	line	39
	clrf	((c:1216))^0400h,c	;volatile
	line	40
	
l1141:
	movlw	low(02h)
	movwf	((c:1217))^0400h,c	;volatile
	line	41
	
l1143:
	clrf	((c:1218))^0400h,c	;volatile
	line	43
	
l1145:
	movlb	4	; () banked
	setf	((1024))&0ffh	;volatile
	line	44
	
l1147:; BSR set to: 4

	setf	((1032))&0ffh	;volatile
	line	45
	movlw	low(03Fh)
	movwf	((1040))&0ffh	;volatile
	line	46
	movlw	low(0F9h)
	movwf	((1048))&0ffh	;volatile
	line	47
	movlw	low(07h)
	movwf	((1056))&0ffh	;volatile
	line	49
	
l1149:; BSR set to: 4

	setf	((c:1222))^0400h,c	;volatile
	line	50
	
l1151:; BSR set to: 4

	setf	((c:1223))^0400h,c	;volatile
	line	51
	movlw	low(0BFh)
	movwf	((c:1224))^0400h,c	;volatile
	line	52
	movlw	low(0F9h)
	movwf	((c:1225))^0400h,c	;volatile
	line	53
	movlw	low(0Fh)
	movwf	((c:1226))^0400h,c	;volatile
	line	55
	
l1153:; BSR set to: 4

	clrf	((1026))&0ffh	;volatile
	line	56
	
l1155:; BSR set to: 4

	clrf	((1034))&0ffh	;volatile
	line	57
	
l1157:; BSR set to: 4

	clrf	((1042))&0ffh	;volatile
	line	58
	
l1159:; BSR set to: 4

	clrf	((1050))&0ffh	;volatile
	line	59
	
l1161:; BSR set to: 4

	clrf	((1058))&0ffh	;volatile
	line	61
	
l1163:; BSR set to: 4

	clrf	((1025))&0ffh	;volatile
	line	62
	
l1165:; BSR set to: 4

	clrf	((1033))&0ffh	;volatile
	line	63
	
l1167:; BSR set to: 4

	clrf	((1041))&0ffh	;volatile
	line	64
	
l1169:; BSR set to: 4

	clrf	((1049))&0ffh	;volatile
	line	65
	
l1171:; BSR set to: 4

	clrf	((1057))&0ffh	;volatile
	line	67
	
l1173:; BSR set to: 4

	setf	((1027))&0ffh	;volatile
	line	68
	
l1175:; BSR set to: 4

	setf	((1035))&0ffh	;volatile
	line	69
	
l1177:; BSR set to: 4

	setf	((1043))&0ffh	;volatile
	line	70
	
l1179:; BSR set to: 4

	setf	((1051))&0ffh	;volatile
	line	71
	movlw	low(07h)
	movwf	((1059))&0ffh	;volatile
	line	73
	
l1181:; BSR set to: 4

	setf	((1028))&0ffh	;volatile
	line	74
	
l1183:; BSR set to: 4

	setf	((1036))&0ffh	;volatile
	line	75
	
l1185:; BSR set to: 4

	setf	((1044))&0ffh	;volatile
	line	76
	
l1187:; BSR set to: 4

	setf	((1052))&0ffh	;volatile
	line	77
	movlw	low(0Fh)
	movwf	((1060))&0ffh	;volatile
	line	79
	movlw	low(017h)
	movlb	2	; () banked
	movwf	((626))&0ffh	;volatile
	line	80
	movlw	low(020h)
	movwf	((535))&0ffh	;volatile
	line	81
	
l158:; BSR set to: 2

	return	;funcret
	callstack 0
GLOBAL	__end_of_PinsInitialize
	__end_of_PinsInitialize:
	signat	_PinsInitialize,89
	global	_DelayMsWithCommand

;; *************** function _DelayMsWithCommand *****************
;; Defined at:
;;		line 207 in file "main.c"
;; Parameters:    Size  Location     Type
;;  delayMs         2    7[COMRAM] unsigned short 
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;                  1    wreg      void 
;; Registers used:
;;		wreg, fsr2l, fsr2h, status,2, status,0, cstack
;; Tracked objects:
;;		On entry : 0/0
;;		On exit  : 0/0
;;		Unchanged: 0/0
;; Data sizes:     COMRAM   BANK5   BANK6   BANK7   BANK8   BANK9  BANK10  BANK11  BANK12  BANK13  BANK14  BANK15  BANK16  BANK17  BANK18  BANK19  BANK20  BANK21  BANK22  BANK23  BANK24  BANK25  BANK26  BANK27  BANK28  BANK29  BANK30  BANK31  BANK32  BANK33  BANK34  BANK35  BANK36
;;      Params:         2       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0
;;      Locals:         0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0
;;      Temps:          1       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0
;;      Totals:         3       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0
;;Total ram usage:        3 bytes
;; Hardware stack levels used: 1
;; Hardware stack levels required when called: 3
;; This function calls:
;;		_XBeeCommandTask
;; This function is called by:
;;		_main
;; This function uses a non-reentrant model
;;
psect	text3,class=CODE,space=0,reloc=2,group=0
	line	207
global __ptext3
__ptext3:
psect	text3
	file	"main.c"
	line	207
	
_DelayMsWithCommand:; BSR set to: 2

;incstack = 0
	callstack 123
	line	209
	
l1323:
	goto	l1329
	line	211
	
l1325:
	call	_XBeeCommandTask	;wreg free
	line	212
	
l1327:
	asmopt push
asmopt off
movlw	21
movwf	(??_DelayMsWithCommand+0)^0500h,c
	movlw	198
u537:
decfsz	wreg,f
	bra	u537
	decfsz	(??_DelayMsWithCommand+0)^0500h,c,f
	bra	u537
	nop2
asmopt pop

	line	209
	
l1329:
	decf	((c:DelayMsWithCommand@delayMs))^0500h,c
	btfss	status,0
	decf	((c:DelayMsWithCommand@delayMs+1))^0500h,c
		incf	((c:DelayMsWithCommand@delayMs))^0500h,c,w
	bnz	u521
	incf	((c:DelayMsWithCommand@delayMs+1))^0500h,c,w
	btfss	status,2
	goto	u521
	goto	u520

u521:
	goto	l1325
u520:
	line	214
	
l216:
	return	;funcret
	callstack 0
GLOBAL	__end_of_DelayMsWithCommand
	__end_of_DelayMsWithCommand:
	signat	_DelayMsWithCommand,4217
	global	_XBeeCommandTask

;; *************** function _XBeeCommandTask *****************
;; Defined at:
;;		line 113 in file "main.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;  byte            1    6[COMRAM] unsigned char 
;; Return value:  Size  Location     Type
;;                  1    wreg      void 
;; Registers used:
;;		wreg, fsr2l, fsr2h, status,2, status,0, cstack
;; Tracked objects:
;;		On entry : 0/0
;;		On exit  : 0/0
;;		Unchanged: 0/0
;; Data sizes:     COMRAM   BANK5   BANK6   BANK7   BANK8   BANK9  BANK10  BANK11  BANK12  BANK13  BANK14  BANK15  BANK16  BANK17  BANK18  BANK19  BANK20  BANK21  BANK22  BANK23  BANK24  BANK25  BANK26  BANK27  BANK28  BANK29  BANK30  BANK31  BANK32  BANK33  BANK34  BANK35  BANK36
;;      Params:         0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0
;;      Locals:         1       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0
;;      Temps:          0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0
;;      Totals:         1       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0
;;Total ram usage:        1 bytes
;; Hardware stack levels used: 1
;; Hardware stack levels required when called: 2
;; This function calls:
;;		_RequestBootloader
;;		_XBeePayloadIsBootCommand
;; This function is called by:
;;		_DelayMsWithCommand
;; This function uses a non-reentrant model
;;
psect	text4,class=CODE,space=0,reloc=2,group=0
	line	113
global __ptext4
__ptext4:
psect	text4
	file	"main.c"
	line	113
	
_XBeeCommandTask:
;incstack = 0
	callstack 123
	line	132
	
l1259:
	movlb	2	; () banked
	btfsc	((690))&0ffh,3	;volatile
	goto	u341
	goto	u340
u341:
	goto	l187
u340:
	
l1261:; BSR set to: 2

	btfsc	((690))&0ffh,1	;volatile
	goto	u351
	goto	u350
u351:
	goto	l187
u350:
	
l1263:; BSR set to: 2

	btfss	((690))&0ffh,6	;volatile
	goto	u361
	goto	u360
u361:
	goto	l188
u360:
	
l187:; BSR set to: 2

	line	134
	bcf	((690))&0ffh,3	;volatile
	line	135
	bcf	((690))&0ffh,1	;volatile
	line	136
	bcf	((690))&0ffh,6	;volatile
	line	137
	clrf	((c:XBeeCommandTask@state))^0500h,c
	goto	l188
	line	140
	
l189:; BSR set to: 2

	line	142
	movff	(673),(c:XBeeCommandTask@byte)	;volatile
	line	144
	goto	l1321
	line	147
	
l1265:; BSR set to: 2

		movlw	126
	xorwf	((c:XBeeCommandTask@byte))^0500h,c,w
	btfss	status,2
	goto	u371
	goto	u370

u371:
	goto	l188
u370:
	line	149
	
l1267:; BSR set to: 2

	movlw	low(01h)
	movwf	((c:XBeeCommandTask@state))^0500h,c
	goto	l188
	line	154
	
l1269:; BSR set to: 2

	movf	((c:XBeeCommandTask@byte))^0500h,c,w
	movwf	((c:XBeeCommandTask@xbeeLen+1))^0500h,c
	clrf	((c:XBeeCommandTask@xbeeLen))^0500h,c
	line	155
	movlw	low(02h)
	movwf	((c:XBeeCommandTask@state))^0500h,c
	line	156
	goto	l188
	line	159
	
l1271:; BSR set to: 2

	movf	((c:XBeeCommandTask@byte))^0500h,c,w
	iorwf	((c:XBeeCommandTask@xbeeLen))^0500h,c
	line	160
	
l1273:; BSR set to: 2

	clrf	((c:XBeeCommandTask@bytesRead+1))^0500h,c
	movlw	low(0)
	movwf	((c:XBeeCommandTask@bytesRead))^0500h,c
	line	161
	
l1275:; BSR set to: 2

	clrf	((c:XBeeCommandTask@checksum))^0500h,c
	line	162
	
l1277:; BSR set to: 2

	clrf	((c:XBeeCommandTask@payloadIndex))^0500h,c
	line	163
	
l1279:; BSR set to: 2

	clrf	((c:XBeeCommandTask@payloadLength))^0500h,c
	line	164
	
l1281:; BSR set to: 2

	movf	((c:XBeeCommandTask@xbeeLen))^0500h,c,w
iorwf	((c:XBeeCommandTask@xbeeLen+1))^0500h,c,w
	btfsc	status,2
	goto	u381
	goto	u380

u381:
	movlw	1
	goto	u390
u380:
	movlw	0
u390:
	movwf	((c:XBeeCommandTask@discardFrame))^0500h,c
	line	165
	
l1283:; BSR set to: 2

	movf	((c:XBeeCommandTask@xbeeLen))^0500h,c,w
iorwf	((c:XBeeCommandTask@xbeeLen+1))^0500h,c,w
	btfss	status,2
	goto	u401
	goto	u400

u401:
	goto	l1287
u400:
	
l1285:; BSR set to: 2

	clrf	((c:XBeeCommandTask@state))^0500h,c
	goto	l188
	
l1287:; BSR set to: 2

	movlw	low(03h)
	movwf	((c:XBeeCommandTask@state))^0500h,c
	goto	l188
	line	169
	
l1289:; BSR set to: 2

	movf	((c:XBeeCommandTask@checksum))^0500h,c,w
	addwf	((c:XBeeCommandTask@byte))^0500h,c,w
	movwf	((c:XBeeCommandTask@checksum))^0500h,c
	line	170
	movf	((c:XBeeCommandTask@bytesRead))^0500h,c,w
iorwf	((c:XBeeCommandTask@bytesRead+1))^0500h,c,w
	btfss	status,2
	goto	u411
	goto	u410

u411:
	goto	l1293
u410:
	line	172
	
l1291:; BSR set to: 2

		movlw	144
	xorwf	((c:XBeeCommandTask@byte))^0500h,c,w
	btfss	status,2
	goto	u421
	goto	u420

u421:
	movlw	1
	goto	u430
u420:
	movlw	0
u430:
	movwf	((c:XBeeCommandTask@discardFrame))^0500h,c
	line	173
	goto	l1305
	line	174
	
l1293:; BSR set to: 2

	movf	((c:XBeeCommandTask@discardFrame))^0500h,c,w
	btfss	status,2
	goto	u441
	goto	u440
u441:
	goto	l1305
u440:
	
l1295:; BSR set to: 2

		movf	((c:XBeeCommandTask@bytesRead+1))^0500h,c,w
	bnz	u450
	movlw	12
	subwf	 ((c:XBeeCommandTask@bytesRead))^0500h,c,w
	btfss	status,0
	goto	u451
	goto	u450

u451:
	goto	l1305
u450:
	line	176
	
l1297:; BSR set to: 2

		movlw	08h-0
	cpfslt	((c:XBeeCommandTask@payloadIndex))^0500h,c
	goto	u461
	goto	u460

u461:
	goto	l1303
u460:
	line	178
	
l1299:; BSR set to: 2

	movlw	low(XBeeCommandTask@payload)
	addwf	((c:XBeeCommandTask@payloadIndex))^0500h,c,w
	movwf	c:fsr2l
	clrf	1+c:fsr2l
	movlw	high(XBeeCommandTask@payload)
	addwfc	1+c:fsr2l
	movff	(c:XBeeCommandTask@byte),indf2

	
l1301:; BSR set to: 2

	incf	((c:XBeeCommandTask@payloadIndex))^0500h,c
	line	180
	
l1303:; BSR set to: 2

	incf	((c:XBeeCommandTask@payloadLength))^0500h,c
	line	183
	
l1305:; BSR set to: 2

	infsnz	((c:XBeeCommandTask@bytesRead))^0500h,c
	incf	((c:XBeeCommandTask@bytesRead+1))^0500h,c
	line	184
	
l1307:; BSR set to: 2

		movf	((c:XBeeCommandTask@xbeeLen))^0500h,c,w
	subwf	((c:XBeeCommandTask@bytesRead))^0500h,c,w
	movf	((c:XBeeCommandTask@xbeeLen+1))^0500h,c,w
	subwfb	((c:XBeeCommandTask@bytesRead+1))^0500h,c,w
	btfss	status,0
	goto	u471
	goto	u470

u471:
	goto	l188
u470:
	line	186
	
l1309:; BSR set to: 2

	movlw	low(04h)
	movwf	((c:XBeeCommandTask@state))^0500h,c
	goto	l188
	line	190
	
l206:; BSR set to: 2

	line	191
	clrf	((c:XBeeCommandTask@state))^0500h,c
	line	192
	
l1311:; BSR set to: 2

	movf	((c:XBeeCommandTask@checksum))^0500h,c,w
	addwf	((c:XBeeCommandTask@byte))^0500h,c,w
	xorlw	0FFh
	btfss	status,2
	goto	u481
	goto	u480
u481:
	goto	l188
u480:
	
l1313:; BSR set to: 2

	movf	((c:XBeeCommandTask@discardFrame))^0500h,c,w
	btfss	status,2
	goto	u491
	goto	u490
u491:
	goto	l188
u490:
	
l1315:; BSR set to: 2

		movlw	low(XBeeCommandTask@payload)
	movwf	((c:XBeePayloadIsBootCommand@payload))^0500h,c
	movlw	high(XBeeCommandTask@payload)
	movwf	((c:XBeePayloadIsBootCommand@payload+1))^0500h,c

	movff	(c:XBeeCommandTask@payloadLength),(c:XBeePayloadIsBootCommand@payloadLength)
	call	_XBeePayloadIsBootCommand	;wreg free
	iorlw	0
	btfsc	status,2
	goto	u501
	goto	u500
u501:
	goto	l188
u500:
	line	196
	
l1317:
	call	_RequestBootloader	;wreg free
	goto	l188
	line	203
	
l1321:; BSR set to: 2

	movf	((c:XBeeCommandTask@state))^0500h,c,w
	; Switch size 1, requested type "simple"
; Number of cases is 5, Range of values is 0 to 4
; switch strategies available:
; Name         Instructions Cycles
; simple_byte           16     9 (average)
;	Chosen strategy is simple_byte

	xorlw	0^0	; case 0
	skipnz
	goto	l1265
	xorlw	1^0	; case 1
	skipnz
	goto	l1269
	xorlw	2^1	; case 2
	skipnz
	goto	l1271
	xorlw	3^2	; case 3
	skipnz
	goto	l1289
	xorlw	4^3	; case 4
	skipnz
	goto	l206
	goto	l1285

	line	204
	
l188:
	line	140
	movlb	2	; () banked
	btfss	((688))&0ffh,1	;volatile
	goto	u511
	goto	u510
u511:
	goto	l189
u510:
	line	205
	
l210:; BSR set to: 2

	return	;funcret
	callstack 0
GLOBAL	__end_of_XBeeCommandTask
	__end_of_XBeeCommandTask:
	signat	_XBeeCommandTask,89
	global	_XBeePayloadIsBootCommand

;; *************** function _XBeePayloadIsBootCommand *****************
;; Defined at:
;;		line 104 in file "main.c"
;; Parameters:    Size  Location     Type
;;  payload         2    0[COMRAM] PTR const unsigned char 
;;		 -> XBeeCommandTask@payload(8), 
;;  payloadLengt    1    2[COMRAM] unsigned char 
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;                  1    wreg      _Bool 
;; Registers used:
;;		wreg, fsr2l, fsr2h, status,2, status,0
;; Tracked objects:
;;		On entry : 0/0
;;		On exit  : 0/0
;;		Unchanged: 0/0
;; Data sizes:     COMRAM   BANK5   BANK6   BANK7   BANK8   BANK9  BANK10  BANK11  BANK12  BANK13  BANK14  BANK15  BANK16  BANK17  BANK18  BANK19  BANK20  BANK21  BANK22  BANK23  BANK24  BANK25  BANK26  BANK27  BANK28  BANK29  BANK30  BANK31  BANK32  BANK33  BANK34  BANK35  BANK36
;;      Params:         3       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0
;;      Locals:         1       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0
;;      Temps:          1       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0
;;      Totals:         5       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0
;;Total ram usage:        5 bytes
;; Hardware stack levels used: 1
;; This function calls:
;;		Nothing
;; This function is called by:
;;		_XBeeCommandTask
;; This function uses a non-reentrant model
;;
psect	text5,class=CODE,space=0,reloc=2,group=0
	line	104
global __ptext5
__ptext5:
psect	text5
	file	"main.c"
	line	104
	
_XBeePayloadIsBootCommand:; BSR set to: 2

;incstack = 0
	callstack 124
	line	106
	
l1235:
	clrf	((c:_XBeePayloadIsBootCommand$293))^0500h,c
	
l1237:
		movlw	4
	xorwf	((c:XBeePayloadIsBootCommand@payloadLength))^0500h,c,w
	btfss	status,2
	goto	u291
	goto	u290

u291:
	goto	l165
u290:
	
l1239:
	movff	(c:XBeePayloadIsBootCommand@payload),fsr2l
	movff	(c:XBeePayloadIsBootCommand@payload+1),fsr2h
	movlw	66
	xorwf	postinc2,w
	btfss	status,2
	goto	u301
	goto	u300

u301:
	goto	l165
u300:
	
l1241:
	lfsr	2,01h
	movf	((c:XBeePayloadIsBootCommand@payload))^0500h,c,w
	addwf	fsr2l
	movf	((c:XBeePayloadIsBootCommand@payload+1))^0500h,c,w
	addwfc	fsr2h
	movlw	79
	xorwf	postinc2,w
	btfss	status,2
	goto	u311
	goto	u310

u311:
	goto	l165
u310:
	
l1243:
	lfsr	2,02h
	movf	((c:XBeePayloadIsBootCommand@payload))^0500h,c,w
	addwf	fsr2l
	movf	((c:XBeePayloadIsBootCommand@payload+1))^0500h,c,w
	addwfc	fsr2h
	movlw	79
	xorwf	postinc2,w
	btfss	status,2
	goto	u321
	goto	u320

u321:
	goto	l165
u320:
	
l1245:
	lfsr	2,03h
	movf	((c:XBeePayloadIsBootCommand@payload))^0500h,c,w
	addwf	fsr2l
	movf	((c:XBeePayloadIsBootCommand@payload+1))^0500h,c,w
	addwfc	fsr2h
	movlw	84
	xorwf	postinc2,w
	btfss	status,2
	goto	u331
	goto	u330

u331:
	goto	l165
u330:
	
l1247:
	movlw	low(01h)
	movwf	((c:_XBeePayloadIsBootCommand$293))^0500h,c
	
l165:
	movf	((c:_XBeePayloadIsBootCommand$293))^0500h,c,w
	line	111
	
l166:
	return	;funcret
	callstack 0
GLOBAL	__end_of_XBeePayloadIsBootCommand
	__end_of_XBeePayloadIsBootCommand:
	signat	_XBeePayloadIsBootCommand,8313
	global	_RequestBootloader

;; *************** function _RequestBootloader *****************
;; Defined at:
;;		line 245 in file "main.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;                  1    wreg      void 
;; Registers used:
;;		wreg, status,2, cstack
;; Tracked objects:
;;		On entry : 0/0
;;		On exit  : 0/0
;;		Unchanged: 0/0
;; Data sizes:     COMRAM   BANK5   BANK6   BANK7   BANK8   BANK9  BANK10  BANK11  BANK12  BANK13  BANK14  BANK15  BANK16  BANK17  BANK18  BANK19  BANK20  BANK21  BANK22  BANK23  BANK24  BANK25  BANK26  BANK27  BANK28  BANK29  BANK30  BANK31  BANK32  BANK33  BANK34  BANK35  BANK36
;;      Params:         0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0
;;      Locals:         0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0
;;      Temps:          0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0
;;      Totals:         0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0
;;Total ram usage:        0 bytes
;; Hardware stack levels used: 1
;; Hardware stack levels required when called: 1
;; This function calls:
;;		_EepromWriteByte
;; This function is called by:
;;		_XBeeCommandTask
;; This function uses a non-reentrant model
;;
psect	text6,class=CODE,space=0,reloc=2,group=0
	line	245
global __ptext6
__ptext6:
psect	text6
	file	"main.c"
	line	245
	
_RequestBootloader:
;incstack = 0
	callstack 123
	line	247
	
l1251:
	movlw	low(0AAh)
	movwf	((c:_unlockKeyHigh))^0500h,c
	line	248
	movlw	low(055h)
	movwf	((c:_unlockKeyLow))^0500h,c
	line	249
	
l1253:
	movlw	low(0380000h)
	movwf	((c:EepromWriteByte@address))^0500h,c
	movlw	high(0380000h)
	movwf	((c:EepromWriteByte@address+1))^0500h,c
	movlw	low highword(0380000h)
	movwf	((c:EepromWriteByte@address+2))^0500h,c
	movlw	high highword(0380000h)
	movwf	((c:EepromWriteByte@address+3))^0500h,c
	movlw	low(0AAh)
	movwf	((c:EepromWriteByte@data))^0500h,c
	call	_EepromWriteByte	;wreg free
	line	250
	
l1255:
	clrf	((c:_unlockKeyHigh))^0500h,c
	line	251
	
l1257:
	clrf	((c:_unlockKeyLow))^0500h,c
	line	252
# 252 "main.c"
reset ;# 
psect	text6
	line	253
	
l225:
	return	;funcret
	callstack 0
GLOBAL	__end_of_RequestBootloader
	__end_of_RequestBootloader:
	signat	_RequestBootloader,89
	global	_EepromWriteByte

;; *************** function _EepromWriteByte *****************
;; Defined at:
;;		line 216 in file "main.c"
;; Parameters:    Size  Location     Type
;;  address         4    0[COMRAM] unsigned long 
;;  data            1    4[COMRAM] unsigned char 
;; Auto vars:     Size  Location     Type
;;  gieState        1    5[COMRAM] unsigned char 
;; Return value:  Size  Location     Type
;;                  1    wreg      void 
;; Registers used:
;;		wreg, status,2
;; Tracked objects:
;;		On entry : 0/0
;;		On exit  : 0/0
;;		Unchanged: 0/0
;; Data sizes:     COMRAM   BANK5   BANK6   BANK7   BANK8   BANK9  BANK10  BANK11  BANK12  BANK13  BANK14  BANK15  BANK16  BANK17  BANK18  BANK19  BANK20  BANK21  BANK22  BANK23  BANK24  BANK25  BANK26  BANK27  BANK28  BANK29  BANK30  BANK31  BANK32  BANK33  BANK34  BANK35  BANK36
;;      Params:         5       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0
;;      Locals:         1       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0
;;      Temps:          0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0
;;      Totals:         6       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0
;;Total ram usage:        6 bytes
;; Hardware stack levels used: 1
;; This function calls:
;;		Nothing
;; This function is called by:
;;		_RequestBootloader
;; This function uses a non-reentrant model
;;
psect	text7,class=CODE,space=0,reloc=2,group=0
	line	216
global __ptext7
__ptext7:
psect	text7
	file	"main.c"
	line	216
	
_EepromWriteByte:
;incstack = 0
	callstack 123
	line	218
	
l1215:
	movlw	0
	btfsc	((c:1238))^0400h,c,7	;volatile
	movlw	1
	movwf	((c:EepromWriteByte@gieState))^0500h,c
	line	220
	
l1217:
	movff	0+2+(c:EepromWriteByte@address),(69)	;volatile
	line	221
	
l1219:
	movff	0+1+(c:EepromWriteByte@address),(68)	;volatile
	line	222
	
l1221:
	movff	(c:EepromWriteByte@address),(67)	;volatile
	line	223
	
l1223:
	movff	(c:EepromWriteByte@data),(70)	;volatile
	line	224
	
l1225:
	movlb	0	; () banked
	movf	((65))&0ffh,w	;volsfr
	andlw	not (((1<<3)-1)<<0)
	iorlw	(03h & ((1<<3)-1))<<0
	movwf	((65))&0ffh	;volsfr
	line	226
	
l1227:; BSR set to: 0

	bcf	((c:1238))^0400h,c,7	;volatile
	line	228
# 228 "main.c"
asmopt push ;# 
	line	229
# 229 "main.c"
asmopt off ;# 
	line	230
# 230 "main.c"
banksel(_NVMLOCK) ;# 
psect	text7
	line	231
	
l1229:
	movff	(c:_unlockKeyLow),(66)	;volatile
	line	232
# 232 "main.c"
MOVF (_unlockKeyHigh&0xFF),w,c ;# 
	line	233
# 233 "main.c"
MOVWF (_NVMLOCK&0xFF),b ;# 
	line	234
# 234 "main.c"
bsf (_NVMCON0bits&0xFF),0x0,b ;# 
	line	235
# 235 "main.c"
asmopt pop ;# 
psect	text7
	line	237
	
l1231:
	btfsc	(c:EepromWriteByte@gieState)^0500h,c,0
	bra	u275
	bcf	((c:1238))^0400h,c,7	;volatile
	bra	u276
	u275:
	bsf	((c:1238))^0400h,c,7	;volatile
	u276:

	line	241
	
l219:
	line	239
	movlb	0	; () banked
	btfsc	((64))&0ffh,0	;volatile
	goto	u281
	goto	u280
u281:
	goto	l219
u280:
	line	242
	
l1233:; BSR set to: 0

	movlw	((0 & ((1<<3)-1))<<0)|not (((1<<3)-1)<<0)
	andwf	((65))&0ffh	;volsfr
	line	243
	
l222:; BSR set to: 0

	return	;funcret
	callstack 0
GLOBAL	__end_of_EepromWriteByte
	__end_of_EepromWriteByte:
	signat	_EepromWriteByte,8313
	global	_ClockInitialize

;; *************** function _ClockInitialize *****************
;; Defined at:
;;		line 25 in file "main.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;                  1    wreg      void 
;; Registers used:
;;		wreg, status,2
;; Tracked objects:
;;		On entry : 0/0
;;		On exit  : 0/0
;;		Unchanged: 0/0
;; Data sizes:     COMRAM   BANK5   BANK6   BANK7   BANK8   BANK9  BANK10  BANK11  BANK12  BANK13  BANK14  BANK15  BANK16  BANK17  BANK18  BANK19  BANK20  BANK21  BANK22  BANK23  BANK24  BANK25  BANK26  BANK27  BANK28  BANK29  BANK30  BANK31  BANK32  BANK33  BANK34  BANK35  BANK36
;;      Params:         0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0
;;      Locals:         0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0
;;      Temps:          0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0
;;      Totals:         0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0
;;Total ram usage:        0 bytes
;; Hardware stack levels used: 1
;; This function calls:
;;		Nothing
;; This function is called by:
;;		_main
;; This function uses a non-reentrant model
;;
psect	text8,class=CODE,space=0,reloc=2,group=0
	line	25
global __ptext8
__ptext8:
psect	text8
	file	"main.c"
	line	25
	
_ClockInitialize:; BSR set to: 0

;incstack = 0
	callstack 126
	line	27
	
l1129:
	movlw	low(060h)
	movlb	0	; () banked
	movwf	((173))&0ffh	;volatile
	line	28
	
l1131:; BSR set to: 0

	clrf	((175))&0ffh	;volatile
	line	29
	
l1133:; BSR set to: 0

	clrf	((179))&0ffh	;volatile
	line	30
	movlw	low(08h)
	movwf	((177))&0ffh	;volatile
	line	31
	
l1135:; BSR set to: 0

	clrf	((176))&0ffh	;volatile
	line	32
	
l1137:; BSR set to: 0

	clrf	((172))&0ffh	;volatile
	line	33
	
l155:; BSR set to: 0

	return	;funcret
	callstack 0
GLOBAL	__end_of_ClockInitialize
	__end_of_ClockInitialize:
	signat	_ClockInitialize,89
psect	smallconst,class=SMALLCONST,space=0,reloc=2,noexec
global __psmallconst
__psmallconst:
	db	0
	db 0	; dummy byte at the end
	global	__smallconst
__smallconst	set	__psmallconst
	global	__mediumconst
__mediumconst	set	__psmallconst
	GLOBAL	__activetblptr
__activetblptr	EQU	3
	psect	intsave_regs,class=BIGRAM,space=1,noexec
	PSECT	rparam,class=COMRAM,space=1,noexec
	GLOBAL	__Lrparam
	FNCONF	rparam,??,?
	GLOBAL	___rparam_used
	___rparam_used EQU 1
	GLOBAL	___param_bank
	___param_bank EQU 0
GLOBAL	__Lparam, __Hparam
GLOBAL	__Lrparam, __Hrparam
__Lparam	EQU	__Lrparam
__Hparam	EQU	__Hrparam
	end
