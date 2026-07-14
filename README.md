# Bootloader MDFU por XBee para PIC18F47Q43

Este repositorio contiene un bootloader MDFU para `PIC18F47Q43` que permite
actualizar firmware por XBee en modo API.

## Contenido

| Carpeta | Descripcion |
| --- | --- |
| `BL.X/` | Proyecto MPLAB X del bootloader |
| `host_flasher/` | Script Python para cargar firmware por XBee |
| `APP_TEST.X/` | Aplicacion ejemplo con parpadeo lento |
| `APP_FAST_BLINK.X/` | Aplicacion ejemplo con parpadeo rapido |
| `docs/` | Documentacion de implementacion |

## Guia principal

Lee primero:

```text
docs/BOOTLOADER_XBEE_GUIDE.md
```

La guia incluye:

- Mapa de memoria.
- Configuracion de MPLAB/MCC/XC8.
- Configuracion exacta de XBee.
- Funciones que debe tener la aplicacion para volver al bootloader.
- Flujo para migrar un proyecto existente sin bootloader.
- Comandos de carga y diagnostico.

## Resumen rapido

La aplicacion debe compilarse para arrancar en:

```text
reset/app start: 0x3000
high interrupt:  0x3008
low interrupt:   0x3018
```

Opciones XC8 usadas por los ejemplos:

```text
-mcodeoffset=0x3000
-mrom=3000-1FFFD
-mno-default-config-bits
```

Los XBee deben estar en:

```text
AP = 1
BD = 3   # 9600 bps
AO = 0   # API Rx Indicator 0x90
```

## Comandos utiles

Verificar XBee local:

```powershell
python host_flasher\xbee_bootloader_host.py --port COM8 --xbee-info --verbose
```

Cargar app si el PIC ya esta en bootloader:

```powershell
cd APP_FAST_BLINK.X
python ..\host_flasher\xbee_bootloader_host.py --port COM8 --hex .\dist\APP_FAST_BLINK.hex --mac 0013A2004240FDC6 --verbose
```

Pedir a una app compatible que vuelva al bootloader y cargar otro firmware:

```powershell
python ..\host_flasher\xbee_bootloader_host.py --port COM8 --mac 0013A2004240FDC6 --request-bootloader --hex ..\APP_TEST.X\dist\APP_TEST.hex --verbose
```

## Nota importante

Si el PIC ya salto a la aplicacion, el bootloader no escucha comandos MDFU.
Para actualizar sin tocar la tarjeta, la aplicacion debe implementar el comando
remoto `BOOT`, escribir `0xAA` en EEPROM `0x380000` y ejecutar `RESET()`.

