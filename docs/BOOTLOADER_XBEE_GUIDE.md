# Guia de implementacion: Bootloader MDFU por XBee API

Esta guia explica como implementar el bootloader de este repositorio en un
proyecto existente, como configurar los XBee y que funciones debe tener el
firmware de aplicacion para poder volver al bootloader y actualizarse por aire.

El ejemplo actual usa:

- MCU: `PIC18F47Q43`
- Compilador: `XC8`
- IDE: `MPLAB X`
- Bootloader: Microchip MDFU Client 8-bit
- Transporte: XBee SX en API mode, usando UART1
- UART entre PIC y XBee remoto: `38400 8N1`
- XBee local al PC: `COM8` a `9600 bps` en las pruebas

## 1. Arquitectura

El sistema tiene tres piezas:

```text
PC host flasher
  |
  | USB / COM, XBee API frames
  v
XBee local  <---- RF ---->  XBee remoto
                              |
                              | UART1 38400 8N1
                              v
                         PIC18F47Q43
                         Bootloader + aplicacion
```

El PC no habla directamente MDFU crudo al PIC. El script
`host_flasher/xbee_bootloader_host.py` encapsula los comandos MDFU dentro de
tramas XBee API `0x10`. El XBee remoto entrega al PIC tramas API `0x90` por
UART. El bootloader extrae el payload real y responde de regreso usando tramas
XBee API `0x10`.

## 2. Mapa de memoria obligatorio

En este proyecto el bootloader ocupa la parte baja de flash y la aplicacion
debe iniciar en `0x3000`.

| Region | Rango |
| --- | --- |
| Bootloader | `0x0000` a `0x2FFF` |
| Aplicacion | `0x3000` a `0x1FFFF` |
| Reset/app start | `0x3000` |
| High interrupt vector | `0x3008` |
| Low interrupt vector | `0x3018` |
| CRC-16 almacenado por flasher | `0x1FFFE` a `0x1FFFF` |
| EEPROM/DFM boot flag | `0x380000` |

Constantes relevantes:

```c
#define BL_APPLICATION_START_ADDRESS          0x3000
#define BL_APPLICATION_INTERRUPT_VECTOR_HIGH  0x3008
#define BL_APPLICATION_INTERRUPT_VECTOR_LOW   0x3018
#define BL_APPLICATION_END_ADDRESS            0x1FFFF
#define EEPROM_BOOT_FLAG_ADDRESS              0x380000
#define BOOT_FLAG_UPDATE_REQUESTED            0xAA
#define BOOT_FLAG_NORMAL_BOOT                 0x00
```

El archivo de aplicacion nunca debe escribir datos utiles en
`0x1FFFE..0x1FFFF`; esos dos bytes los inserta el flasher con el CRC-16 que
valida el bootloader.

## 3. Configuracion del bootloader en MPLAB/MCC

Para recrear el bootloader desde cero en otro proyecto:

1. Crear un proyecto MPLAB X para el mismo MCU.
2. Agregar MCC Melody.
3. Configurar oscilador como en el proyecto de referencia:
   - HFINTOSC
   - `64 MHz`
4. Agregar UART1.
5. Configurar UART1:
   - Baud: `38400`
   - Data bits: `8`
   - Parity: `None`
   - Stop bits: `1`
   - TX: `RC6`
   - RX: `RC7`
6. Agregar MDFU Client 8-bit.
7. Configurar MDFU:
   - Protocol: `UART`
   - Application start address: `0x3000`
   - Verification: `CRC-16`
   - Bootloader firmware verification: deshabilitado en este repo
   - Application image count: `1`
8. Generar codigo.
9. Aplicar los cambios custom descritos abajo.
10. Compilar y grabar `BL.X.production.hex` con programador.

### 3.1. Ajustes de configuracion del bootloader

En `BL.X/mcc_generated_files/bootloader/library/core/bl_config.h`:

```c
#define BL_BOOT_VERIFICATION_ENABLED (0)
#define BL_APPLICATION_START_ADDRESS (0x3000)
#define BL_APPLICATION_INTERRUPT_VECTOR_LOW (0x3018)
#define BL_APPLICATION_INTERRUPT_VECTOR_HIGH (0x3008)
#define BL_APPLICATION_END_ADDRESS (0x1FFFF)
#define BL_STAGING_IMAGE_START (0x3000)
#define BL_STAGING_IMAGE_END (0x1FFFF)
```

La verificacion del bootloader con CRC32 se dejo apagada porque no es necesaria
para el flujo actual y puede bloquear el arranque si el checksum del area de
bootloader no coincide con el generado.

### 3.2. UART1 a 38400 bps

En `BL.X/mcc_generated_files/uart/src/uart1.c`, con FOSC de `64 MHz` y BRGS en
high speed:

```c
U1CON0 = 0xB0;
U1CON1 = 0x80;
U1CON2 = 0x08;

// 38400 bps @ 64 MHz, BRGS high speed
U1BRGL = 0xA0;
U1BRGH = 0x01;
```

Si regeneras MCC, revisa que estos valores no regresen a `115200`.

### 3.3. Adaptador XBee API del bootloader

El bootloader generado por MCC espera bytes MDFU por UART, pero el XBee remoto
manda tramas API completas. Por eso `COM_FrameTransfer()` debe:

1. Esperar `0x7E`.
2. Leer longitud.
3. Validar checksum XBee.
4. Aceptar solo tramas `0x90`.
5. Guardar la MAC origen para responder.
6. Extraer el payload desde el byte 12 de la trama `0x90`.
7. Entregar ese payload al FTP/MDFU.

El archivo de referencia esta en:

```text
BL.X/mcc_generated_files/bootloader/library/com_adapter/com_adapter.c
```

Puntos clave:

```c
// Frame recibido desde XBee remoto hacia el PIC.
#define XBEE_RX_FRAME_TYPE 0x90

// Frame enviado desde PIC hacia XBee remoto.
#define XBEE_TX_FRAME_TYPE 0x10
```

Cabecera de trama XBee RX `0x90`:

```text
byte 0      frame type = 0x90
bytes 1-8   source MAC64
bytes 9-10  source network address 16-bit
byte 11     receive options
byte 12..   payload real para MDFU
```

Cabecera de trama XBee TX `0x10`:

```text
byte 0      frame type = 0x10
byte 1      frame id
bytes 2-9   destination MAC64
bytes 10-11 destination network address 16-bit
byte 12     broadcast radius
byte 13     options
byte 14..   payload real de respuesta MDFU
```

### 3.4. Escrituras parciales de flash

Los XBee SX pueden rechazar tramas grandes con `delivery=0x74 (Payload too
large)`. Por eso el host parte cada pagina de flash en chunks mas chicos.

Para soportarlo, el bootloader fue ajustado para escribir longitudes parciales
en `BL_BootCommandProcess()`:

```c
uint16_t writeLength = 0U;
if (bufferLength > (BL_COMMAND_HEADER_SIZE + BL_BLOCK_HEADER_SIZE))
{
    writeLength = (uint16_t)(bufferLength - (BL_COMMAND_HEADER_SIZE + BL_BLOCK_HEADER_SIZE));
}

flash_address_t targetAddress = (flash_address_t) commandHeader.startAddress + stagingAreaOffset;
if ((targetAddress >= (flash_address_t) BL_STAGING_IMAGE_START)
        && (writeLength > 0U)
        && (writeLength <= (uint16_t) PROGMEM_PAGE_SIZE)
        && ((FLASH_PageOffsetGet(targetAddress) + writeLength) <= (uint16_t) PROGMEM_PAGE_SIZE))
{
    bl_mem_result_t memoryStatus = BL_FlashWrite(
        targetAddress,
        (flash_data_t *) &(bootDataPtr[BL_COMMAND_HEADER_SIZE + BL_BLOCK_HEADER_SIZE]),
        writeLength
    );
}
```

Esto permite enviar, por ejemplo, una pagina de 256 bytes en dos bloques: 200
bytes y 56 bytes.

## 4. Configuracion de XBee

Configura ambos XBee con XCTU.

### 4.1. XBee local, conectado al PC

| Parametro | Valor |
| --- | --- |
| Port | `COM8` en las pruebas |
| Baud | El configurado en el XBee local; en las pruebas puede seguir en `9600` |
| Data format | `8/N/1` |
| `AP` | `1` API Mode Without Escapes |
| `BD` | Segun el baud local usado por `--baud` |
| `AO` | `0` API Rx Indicator `0x90` |
| `ID` | Mismo PAN ID que el remoto |

### 4.2. XBee remoto, conectado al PIC

| Parametro | Valor |
| --- | --- |
| Baud | `38400` |
| Data format | `8/N/1` |
| `AP` | `1` API Mode Without Escapes |
| `BD` | `5` 38400 bps |
| `AO` | `0` API Rx Indicator `0x90` |
| `D6` | `1` RTS flow control |
| `D7` | `1` CTS flow control |
| `ID` | Mismo PAN ID que el local |
| UART DIN/DOUT | Conectado a PIC UART1 |

Conexion UART recomendada:

```text
PIC RC6 / UART1 TX  -> XBee DIN
PIC RC7 / UART1 RX  <- XBee DOUT
PIC RD2 / RTS       -> XBee D6/RTS
GND                 <-> GND
3.3 V               -> XBee VCC
```

Con `D6/RTS` activo, el XBee solo envia datos al PIC cuando la linea RTS del
host esta en nivel de permitir recepcion. En este repo el bootloader y las apps
ejemplo dejan `RD2` como salida digital en bajo para que el XBee pueda entregar
las tramas `0x90`. Si una placa usa otro pin para RTS, actualiza `TRISx`,
`ANSELx` y `LATx` en el bootloader y en la aplicacion.

Importante: el XBee es de `3.3 V`. No alimentarlo con `5 V` ni meter senales
de `5 V` directas a sus pines.

### 4.3. Verificar XBee local

Desde el repo:

```powershell
python host_flasher\xbee_bootloader_host.py --port COM8 --xbee-info --verbose
```

Debe responder algo como:

```text
ATAP: 0x1
ATBD: 0x3
ATID: ...
ATSH: ...
ATSL: ...
ATAI: ...
```

Si no responde, revisar:

- Puerto COM correcto.
- Baud correcto.
- XBee local en `AP=1`.
- XCTU cerrado, porque puede tener tomado el puerto.

## 5. Configuracion de la aplicacion

Una aplicacion que se actualiza con este bootloader debe cumplir estas reglas.

### 5.1. Linker / XC8

Compilar la aplicacion para iniciar en `0x3000`, no en `0x0000`.

Opciones usadas por los ejemplos:

```text
-mcodeoffset=0x3000
-mrom=3000-1FFFD
-mno-default-config-bits
```

Significado:

- `-mcodeoffset=0x3000`: mueve reset/startup a `0x3000`.
- `-mrom=3000-1FFFD`: evita usar el area del bootloader y deja libre el CRC.
- `-mno-default-config-bits`: la app no debe reescribir config bits; los define
  el bootloader grabado por programador.

Si usas interrupciones, verifica tambien:

| Vector | Direccion |
| --- | --- |
| Reset | `0x3000` |
| High interrupt | `0x3008` |
| Low interrupt | `0x3018` |

Si el proyecto existente tiene un linker custom, replica esos rangos ahi.

Para proyectos PIC18 nuevos con `IVTBASE`, revisa la configuracion generada por
MCC. El bootloader deja la app en `0x3000`; por lo tanto la tabla/vector de la
app tambien debe quedar dentro del espacio de aplicacion y no en `0x0000`.
Si el proyecto usa interrupciones high/low clasicas, los vectores esperados son
`0x3008` y `0x3018`. Si usa tabla vectorizada por `IVTBASE`, configura la base
de interrupciones de la app segun el esquema de MCC, pero siempre dentro del
rango de aplicacion.

### 5.1.1. Verificacion del archivo `.map`

Despues de compilar cualquier app, abre el `.map` y verifica:

```text
ACODE=03000h-01FFFDh
preset_vec=03000h
reset_vec ... 003000
```

Ejemplo con PowerShell:

```powershell
Select-String -Path .\dist\APP_FAST_BLINK.map -Pattern "ACODE=03000h-01FFFDh|preset_vec=03000h|reset_vec"
```

Si aparece `reset_vec` en `000000`, la app esta mal compilada para bootloader.
No la cargues por XBee hasta corregir el linker.

### 5.2. No escribir configuration bits desde la app

La aplicacion no debe incluir `#pragma config` si se va a cargar por bootloader.
Los configuration bits pertenecen al bootloader/programador. Si la app intenta
reconfigurarlos, puede generar un HEX que el bootloader no debe escribir.

### 5.3. Reservar los dos bytes finales para CRC

El script host calcula CRC-16 sobre la aplicacion y escribe el resultado en:

```text
0x1FFFE..0x1FFFF
```

La app no debe usar esos bytes.

## 6. Funciones que debe tener el firmware de aplicacion

Para poder regresar al bootloader sin tocar fisicamente la tarjeta, la app debe
tener:

1. Una funcion que escriba `0xAA` en EEPROM/DFM `0x380000`.
2. Una funcion `RequestBootloader()` que llame esa escritura y haga `RESET()`.
3. Un receptor de comando por XBee API.
4. Un comando reservado, en este repo `BOOT`.

### 6.1. Constantes minimas

```c
#define BOOT_FLAG_ADDRESS 0x380000UL
#define BOOT_FLAG_UPDATE_REQUESTED 0xAAU
#define NVM_UNLOCK_KEY 0xAA55U

#define XBEE_START_DELIMITER 0x7EU
#define XBEE_RX_FRAME_TYPE 0x90U
#define XBEE_BOOT_COMMAND_LENGTH 4U
```

### 6.2. Escritura de bandera y reset

La app debe incluir una funcion equivalente a esta:

```c
static uint8_t unlockKeyHigh;
static uint8_t unlockKeyLow;

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
```

Cuando el PIC reinicia, el bootloader ejecuta `ForcedEntryCheck()`, lee
`0x380000`, detecta `0xAA`, limpia la bandera a `0x00` y se queda en modo
bootloader.

### 6.3. Inicializar UART1 en la app

Si tu app existente ya usa UART1 para otra cosa, debes integrar el receptor
`BOOT` con cuidado. Si no lo usa, puedes inicializar UART1 asi:

```c
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
```

PPS usado por los ejemplos:

```c
U1RXPPS = 0x17; // RC7 -> UART1 RX
RC6PPS = 0x20;  // RC6 -> UART1 TX
```

### 6.4. Parser de comando BOOT por XBee API

La app no recibe texto plano. Como `AP=1`, recibe una trama API `0x90`.
El payload `BOOT` viene despues de 12 bytes de cabecera.

La implementacion de referencia esta en:

```text
APP_FAST_BLINK.X/main.c
APP_TEST.X/main.c
```

Funciones clave:

```c
static bool XBeePayloadIsBootCommand(const uint8_t *payload, uint8_t payloadLength);
static void XBeeCommandTask(void);
static void DelayMsWithCommand(uint16_t delayMs);
```

La app debe llamar `XBeeCommandTask()` frecuentemente. Si la app usa delays
largos, reemplazarlos por delays cortos que procesen UART:

```c
static void DelayMsWithCommand(uint16_t delayMs)
{
    while (delayMs-- > 0U)
    {
        XBeeCommandTask();
        __delay_ms(1);
    }
}
```

En un proyecto real con scheduler o main loop, llama `XBeeCommandTask()` en el
loop principal:

```c
while (true)
{
    XBeeCommandTask();
    AppTasks();
}
```

No uses delays largos bloqueantes sin revisar UART, porque la trama XBee puede
llegar mientras la app duerme y el FIFO de UART podria llenarse.

## 7. Script host

El script principal es:

```text
host_flasher/xbee_bootloader_host.py
```

Dependencias:

```powershell
pip install pyserial intelhex
```

En el entorno usado:

```powershell
conda activate hackaton
```

### 7.1. Consultar XBee local

```powershell
python host_flasher\xbee_bootloader_host.py --port COM8 --xbee-info --verbose
```

### 7.2. Cargar firmware cuando el PIC ya esta en bootloader

Desde la carpeta de la app:

```powershell
python ..\host_flasher\xbee_bootloader_host.py --port COM8 --hex .\dist\APP_FAST_BLINK.hex --mac 0013A2004240FDC6 --verbose
```

### 7.3. Pedir a la app que reinicie al bootloader

Si la app ya contiene el receptor `BOOT`:

```powershell
python ..\host_flasher\xbee_bootloader_host.py --port COM8 --mac 0013A2004240FDC6 --request-bootloader
```

### 7.4. Pedir bootloader y cargar en un solo comando

Ejemplo: desde `APP_FAST_BLINK.X`, cargar `APP_TEST`:

```powershell
python ..\host_flasher\xbee_bootloader_host.py --port COM8 --mac 0013A2004240FDC6 --request-bootloader --hex ..\APP_TEST.X\dist\APP_TEST.hex --verbose
```

Ejemplo: desde `APP_TEST.X`, cargar `APP_FAST_BLINK`:

```powershell
python ..\host_flasher\xbee_bootloader_host.py --port COM8 --mac 0013A2004240FDC6 --request-bootloader --hex ..\APP_FAST_BLINK.X\dist\APP_FAST_BLINK.hex --verbose
```

El flujo automatico es:

1. El script manda payload `BOOT` por XBee.
2. La app recibe `BOOT`.
3. La app escribe `0xAA` en EEPROM `0x380000`.
4. La app ejecuta `RESET()`.
5. El bootloader detecta la bandera.
6. El script espera `--boot-wait` segundos.
7. El script inicia MDFU.
8. El bootloader escribe flash y valida CRC.

## 8. Crear una app actualizable desde un proyecto existente

Checklist para migrar un proyecto existente sin bootloader:

1. Guardar una copia del proyecto original.
2. Quitar o aislar `#pragma config` de la app. Los config bits quedan en el
   bootloader.
3. Cambiar build/linker de la app:
   - `-mcodeoffset=0x3000`
   - `-mrom=3000-1FFFD`
   - `-mno-default-config-bits`
4. Si usa interrupciones:
   - Verificar reset en `0x3000`.
   - Verificar high vector en `0x3008`.
   - Verificar low vector en `0x3018`.
5. Agregar la bandera `BOOT_FLAG_ADDRESS = 0x380000`.
6. Agregar `EepromWriteByte()` y `RequestBootloader()`.
7. Agregar inicializacion UART1 a `38400 8N1` o integrar con tu driver UART.
8. Agregar parser XBee API `0x90` para payload `BOOT`.
9. Llamar `XBeeCommandTask()` periodicamente.
10. Compilar y revisar el `.map`.
11. Cargar por bootloader.
12. Probar `--request-bootloader` para confirmar que puede actualizarse de
    nuevo sin programador.

## 9. Compilar ejemplos

Ejemplo lento:

```powershell
cd APP_TEST.X
.\build_xc8.ps1
```

Salida:

```text
APP_TEST.X/dist/APP_TEST.hex
```

Ejemplo rapido:

```powershell
cd APP_FAST_BLINK.X
.\build_xc8.ps1
```

Salida:

```text
APP_FAST_BLINK.X/dist/APP_FAST_BLINK.hex
```

Ambos scripts usan:

```text
-mcodeoffset=0x3000
-mrom=3000-1FFFD
-mno-default-config-bits
```

## 10. Grabar el bootloader por primera vez

La primera vez siempre necesitas programador fisico, por ejemplo PICkit.

1. Abrir MPLAB X o MPLAB IPE.
2. Hacer `Erase Device` si existe una app previa que no quieres preservar.
3. Programar:

```text
BL.X/dist/default/production/BL.X.production.hex
```

4. Resetear el PIC.
5. Si no hay app valida, el bootloader queda esperando.
6. Si hay app valida y no esta puesta la bandera `0xAA`, saltara a la app.

Si el bootloader parece no responder pero `Tx Status` dice `Success`, revisa si
la app ya esta corriendo. El XBee puede estar entregando el paquete, pero la app
no entiende comandos MDFU.

## 11. Diagnostico rapido

### 11.1. XBee local no responde

Sintoma:

```text
ATAP: sin respuesta
```

Revisar:

- Puerto COM.
- Baud local.
- `AP=1`.
- XCTU cerrado.

### 11.2. XBee entrega pero PIC no responde

Sintoma:

```text
Tx Status ... delivery=0x00 (Success)
Timeout esperando respuesta
```

Interpretacion:

- El paquete llego al XBee remoto.
- El PIC no respondio por UART.

Causas comunes:

- PIC esta corriendo la app, no el bootloader.
- App no trae receptor `BOOT`.
- UART PIC-XBee remoto no coincide en baud.
- `D6/RTS` activo pero el PIC no mantiene la linea RTS en nivel de permitir RX.
- TX/RX cruzados incorrectamente.
- XBee remoto no esta conectado al UART correcto.

### 11.3. Payload too large

Sintoma:

```text
delivery=0x74 (Payload too large)
```

Solucion aplicada en este repo:

- El host usa chunks de `200` bytes (`XBEE_SAFE_WRITE_DATA_SIZE`).
- El bootloader acepta escrituras parciales dentro de la pagina.

### 11.4. CRC invalido

Revisar:

- La app fue compilada con `-mrom=3000-1FFFD`.
- La app no usa `0x1FFFE..0x1FFFF`.
- El flasher esta usando el `.hex` correcto.
- No se mezclaron versiones de bootloader/app con mapa distinto.

## 12. Archivos importantes del repo

| Archivo | Uso |
| --- | --- |
| `BL.X/` | Proyecto MPLAB del bootloader |
| `BL.X/mcc_generated_files/bootloader/library/com_adapter/com_adapter.c` | Adaptador XBee API para MDFU |
| `BL.X/mcc_generated_files/bootloader/example/bl_example.c` | Decide si arrancar bootloader o app |
| `BL.X/mcc_generated_files/bootloader/library/core/bl_core.c` | Procesa bloques de escritura flash |
| `BL.X/config.h` | Bandera EEPROM para entrar al bootloader |
| `host_flasher/xbee_bootloader_host.py` | Flasher por XBee desde PC |
| `APP_TEST.X/` | App ejemplo de parpadeo lento |
| `APP_FAST_BLINK.X/` | App ejemplo de parpadeo rapido |

## 13. Flujo recomendado de desarrollo

1. Programar bootloader con PICkit.
2. Cargar `APP_FAST_BLINK.hex` por XBee.
3. Confirmar que parpadea rapido.
4. Cargar `APP_TEST.hex` usando `--request-bootloader`.
5. Confirmar que parpadea lento.
6. Cargar de nuevo `APP_FAST_BLINK.hex` usando `--request-bootloader`.
7. Si los pasos 4 y 6 funcionan, el ciclo OTA por XBee esta completo.

Comando ejemplo:

```powershell
cd C:\Users\ernes\OneDrive\Documentos\GitHub\Bootloader\APP_FAST_BLINK.X
python ..\host_flasher\xbee_bootloader_host.py --port COM8 --mac 0013A2004240FDC6 --request-bootloader --hex ..\APP_TEST.X\dist\APP_TEST.hex --verbose
```

## 14. Reglas de oro

- Bootloader en `0x0000`.
- App en `0x3000`.
- App no debe escribir config bits.
- App no debe usar `0x1FFFE..0x1FFFF`.
- XBee local y remoto en `AP=1`.
- XBee remoto en `BD=5` si el PIC esta a `38400`; el XBee local debe coincidir con el `--baud` del script.
- El PIC no entiende MDFU si ya salto a la app.
- La app debe tener comando remoto `BOOT` si quieres actualizar sin tocar la
  tarjeta.
- Si `Tx Status` dice `Success` pero no hay respuesta MDFU, el problema esta
  despues del enlace RF: app corriendo, UART, parser o estado bootloader.
