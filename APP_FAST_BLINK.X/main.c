#include <xc.h>
#include <stdint.h>
#include <stdbool.h>

#define _XTAL_FREQ 64000000UL

#define BOOT_FLAG_ADDRESS 0x380000UL
#define BOOT_FLAG_UPDATE_REQUESTED 0xAAU
#define NVM_UNLOCK_KEY 0xAA55U
#define XBEE_START_DELIMITER 0x7EU
#define XBEE_RX_FRAME_TYPE 0x90U
#define XBEE_BOOT_COMMAND_LENGTH 4U

static void ClockInitialize(void);
static void PinsInitialize(void);
static void UartInitialize(void);
static void XBeeCommandTask(void);
static void DelayMsWithCommand(uint16_t delayMs);
static void EepromWriteByte(uint32_t address, uint8_t data);
static void RequestBootloader(void);

static uint8_t unlockKeyHigh;
static uint8_t unlockKeyLow;

static void ClockInitialize(void)
{
    OSCCON1 = (0 << _OSCCON1_NDIV_POSN) | (6 << _OSCCON1_NOSC_POSN);
    OSCCON3 = 0x00;
    OSCEN = 0x00;
    OSCFRQ = (8 << _OSCFRQ_HFFRQ_POSN);
    OSCTUNE = 0x00;
    ACTCON = 0x00;
}

static void PinsInitialize(void)
{
    LATA = 0x00;
    LATB = 0x00;
    LATC = 0x00;
    LATD = 0x02; // RD2 low keeps XBee RTS allowing UART RX.
    LATE = 0x00;

    ANSELA = 0xFF;
    ANSELB = 0xFF;
    ANSELC = 0x3F;
    ANSELD = 0xF9;
    ANSELE = 0x07;

    TRISA = 0xFF;
    TRISB = 0xFF;
    TRISC = 0xBF;
    TRISD = 0xF9;
    TRISE = 0x0F;

    ODCONA = 0x00;
    ODCONB = 0x00;
    ODCONC = 0x00;
    ODCOND = 0x00;
    ODCONE = 0x00;

    WPUA = 0x00;
    WPUB = 0x00;
    WPUC = 0x00;
    WPUD = 0x00;
    WPUE = 0x00;

    SLRCONA = 0xFF;
    SLRCONB = 0xFF;
    SLRCONC = 0xFF;
    SLRCOND = 0xFF;
    SLRCONE = 0x07;

    INLVLA = 0xFF;
    INLVLB = 0xFF;
    INLVLC = 0xFF;
    INLVLD = 0xFF;
    INLVLE = 0x0F;

    U1RXPPS = 0x17;
    RC6PPS = 0x20;
}

static void UartInitialize(void)
{
    U1RXCHK = 0x00;
    U1TXCHK = 0x00;
    U1P1L = 0x00;
    U1P1H = 0x00;
    U1P2L = 0x00;
    U1P2H = 0x00;
    U1P3L = 0x00;
    U1P3H = 0x00;
    U1CON0 = 0xB0;
    U1CON1 = 0x80;
    U1CON2 = 0x08;
    U1BRGL = 0xA0;
    U1BRGH = 0x01;
    U1FIFO = 0x2E;
    U1UIR = 0x00;
    U1ERRIR = 0x80;
    U1ERRIE = 0x00;
}

static bool XBeePayloadIsBootCommand(const uint8_t *payload, uint8_t payloadLength)
{
    return (payloadLength == XBEE_BOOT_COMMAND_LENGTH) &&
           (payload[0] == 'B') &&
           (payload[1] == 'O') &&
           (payload[2] == 'O') &&
           (payload[3] == 'T');
}

static void XBeeCommandTask(void)
{
    enum {
        XB_WAIT_START,
        XB_READ_LEN_MSB,
        XB_READ_LEN_LSB,
        XB_READ_DATA,
        XB_VERIFY_CHK
    };

    static uint8_t state = XB_WAIT_START;
    static uint16_t xbeeLen = 0U;
    static uint16_t bytesRead = 0U;
    static uint8_t checksum = 0U;
    static uint8_t payload[8];
    static uint8_t payloadIndex = 0U;
    static uint8_t payloadLength = 0U;
    static bool discardFrame = false;

    if (U1ERRIRbits.FERIF || U1ERRIRbits.RXFOIF || U1ERRIRbits.PERIF)
    {
        U1ERRIRbits.FERIF = 0;
        U1ERRIRbits.RXFOIF = 0;
        U1ERRIRbits.PERIF = 0;
        state = XB_WAIT_START;
    }

    while (!U1FIFObits.RXBE)
    {
        uint8_t byte = U1RXB;

        switch (state)
        {
            case XB_WAIT_START:
                if (byte == XBEE_START_DELIMITER)
                {
                    state = XB_READ_LEN_MSB;
                }
                break;

            case XB_READ_LEN_MSB:
                xbeeLen = ((uint16_t)byte << 8);
                state = XB_READ_LEN_LSB;
                break;

            case XB_READ_LEN_LSB:
                xbeeLen |= byte;
                bytesRead = 0U;
                checksum = 0U;
                payloadIndex = 0U;
                payloadLength = 0U;
                discardFrame = (xbeeLen == 0U);
                state = (xbeeLen > 0U) ? XB_READ_DATA : XB_WAIT_START;
                break;

            case XB_READ_DATA:
                checksum = (uint8_t)(checksum + byte);
                if (bytesRead == 0U)
                {
                    discardFrame = (byte != XBEE_RX_FRAME_TYPE);
                }
                else if ((!discardFrame) && (bytesRead >= 12U))
                {
                    if (payloadIndex < sizeof(payload))
                    {
                        payload[payloadIndex++] = byte;
                    }
                    payloadLength++;
                }

                bytesRead++;
                if (bytesRead >= xbeeLen)
                {
                    state = XB_VERIFY_CHK;
                }
                break;

            case XB_VERIFY_CHK:
                state = XB_WAIT_START;
                if ((((uint8_t)(checksum + byte)) == 0xFFU) &&
                    (!discardFrame) &&
                    XBeePayloadIsBootCommand(payload, payloadLength))
                {
                    RequestBootloader();
                }
                break;

            default:
                state = XB_WAIT_START;
                break;
        }
    }
}

static void DelayMsWithCommand(uint16_t delayMs)
{
    while (delayMs-- > 0U)
    {
        XBeeCommandTask();
        __delay_ms(1);
    }
}

static void EepromWriteByte(uint32_t address, uint8_t data)
{
    uint8_t gieState = INTCON0bits.GIE;

    NVMADRU = (uint8_t)(address >> 16);
    NVMADRH = (uint8_t)(address >> 8);
    NVMADRL = (uint8_t)address;
    NVMDATL = data;
    NVMCON1bits.NVMCMD = 0x03;

    INTCON0bits.GIE = 0;

    asm("asmopt push");
    asm("asmopt off");
    asm("banksel(_NVMLOCK)");
    NVMLOCK = unlockKeyLow;
    asm("MOVF (_unlockKeyHigh&0xFF),w,c");
    asm("MOVWF (_NVMLOCK&0xFF),b");
    asm("bsf (_NVMCON0bits&0xFF)," ___mkstr(_NVMCON0_GO_POSN) ",b");
    asm("asmopt pop");

    INTCON0bits.GIE = gieState;

    while (NVMCON0bits.GO)
    {
    }
    NVMCON1bits.NVMCMD = 0x00;
}

static void RequestBootloader(void)
{
    unlockKeyHigh = (uint8_t)(NVM_UNLOCK_KEY >> 8);
    unlockKeyLow = (uint8_t)NVM_UNLOCK_KEY;
    EepromWriteByte(BOOT_FLAG_ADDRESS, BOOT_FLAG_UPDATE_REQUESTED);
    unlockKeyHigh = 0x00;
    unlockKeyLow = 0x00;
    RESET();
}

void main(void)
{
    ClockInitialize();
    PinsInitialize();
    UartInitialize();

    while (true)
    {
        LATDbits.LATD1 = 0;
        DelayMsWithCommand(100);
        LATDbits.LATD1 = 1;
        DelayMsWithCommand(100);
    }
}
