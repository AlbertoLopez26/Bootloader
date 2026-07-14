# APP_TEST.X

Aplicacion minima para probar el bootloader MDFU/XBee del PIC18F47Q43.

## Que hace

- Arranca como aplicacion en `0x3000`.
- Parpadea `RD1` con un patron de 150 ms encendido y 850 ms apagado.
- Escucha por XBee API el payload `BOOT` para volver al bootloader.
- Incluye `RequestBootloader()`, que escribe `0xAA` en EEPROM `0x380000` y reinicia el PIC para volver al bootloader.
- No usa interrupciones.
- No incluye configuration bits; esos los define el bootloader grabado por programador.

## Compilar

Desde PowerShell:

```powershell
cd APP_TEST.X
.\build_xc8.ps1
```

O desde `cmd.exe`:

```bat
build_xc8.bat
```

Si estas en PowerShell dentro de `APP_TEST.X`, tambien puedes ejecutar:

```powershell
.\build_xc8.bat
```

El HEX esperado queda en:

```text
APP_TEST.X/dist/APP_TEST.hex
```

El script usa estas opciones importantes:

```text
-mcodeoffset=0x3000
-mrom=3000-1FFFD
-mno-default-config-bits
```

Los bytes `0x1FFFE..0x1FFFF` quedan libres porque el flasher escribe ahi el CRC-16 que valida el bootloader.

## Cargar por bootloader

Con el PIC ya en modo bootloader:

```powershell
python ..\host_flasher\xbee_bootloader_host.py --port COM3 --hex .\dist\APP_TEST.hex --verbose
```

Cambia `COM3` por el puerto del XBee local.

## Pedir update desde la app

Si esta app ya esta corriendo, puedes pedirle que reinicie al bootloader:

```powershell
python ..\host_flasher\xbee_bootloader_host.py --port COM8 --mac 0013A2004240FDC6 --request-bootloader
```

O pedir bootloader y cargar otro HEX en un solo comando:

```powershell
python ..\host_flasher\xbee_bootloader_host.py --port COM8 --mac 0013A2004240FDC6 --request-bootloader --hex ..\APP_FAST_BLINK.X\dist\APP_FAST_BLINK.hex --verbose
```

Al reiniciar, el bootloader lee `0xAA` en EEPROM `0x380000`, limpia la bandera y espera una nueva transferencia.
