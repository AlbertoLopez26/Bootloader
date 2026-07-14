# APP_FAST_BLINK.X

Aplicacion minima para probar el bootloader MDFU/XBee del PIC18F47Q43 con parpadeo rapido.

## Que hace

- Arranca como aplicacion en `0x3000`.
- Parpadea `RD1` con 100 ms bajo y 100 ms alto.
- Escucha por XBee API el payload `BOOT` para volver al bootloader.
- Incluye `RequestBootloader()`, que escribe `0xAA` en EEPROM `0x380000` y reinicia el PIC para volver al bootloader.
- No usa interrupciones.
- No incluye configuration bits; esos los define el bootloader grabado por programador.

## Compilar

Desde PowerShell:

```powershell
cd APP_FAST_BLINK.X
.\build_xc8.ps1
```

O desde `cmd.exe`:

```bat
build_xc8.bat
```

El HEX esperado queda en:

```text
APP_FAST_BLINK.X/dist/APP_FAST_BLINK.hex
```

El script usa estas opciones importantes:

```text
-mcodeoffset=0x3000
-mrom=3000-1FFFD
-mno-default-config-bits
```

## Cargar por bootloader

Con el PIC ya en modo bootloader:

```powershell
python ..\host_flasher\xbee_bootloader_host.py --port COM8 --hex .\dist\APP_FAST_BLINK.hex --mac 0013A2004240FDC6 --verbose
```

## Volver al bootloader por XBee

Si esta app ya esta corriendo, puedes pedirle que reinicie al bootloader:

```powershell
python ..\host_flasher\xbee_bootloader_host.py --port COM8 --mac 0013A2004240FDC6 --request-bootloader
```

O pedir bootloader y cargar otro HEX en un solo comando:

```powershell
python ..\host_flasher\xbee_bootloader_host.py --port COM8 --mac 0013A2004240FDC6 --request-bootloader --hex ..\APP_TEST.X\dist\APP_TEST.hex --verbose
```
