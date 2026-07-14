$ErrorActionPreference = "Stop"

$projectDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$distDir = Join-Path $projectDir "dist"
New-Item -ItemType Directory -Force -Path $distDir | Out-Null

$xc8 = "xc8-cc"
$xc8Candidates = @(
    "C:\Program Files\Microchip\xc8\v*\bin\xc8-cc.exe",
    "C:\Program Files (x86)\Microchip\xc8\v*\bin\xc8-cc.exe"
)

if (-not (Get-Command $xc8 -ErrorAction SilentlyContinue)) {
    $foundXc8 = $xc8Candidates |
        ForEach-Object { Get-ChildItem -Path $_ -ErrorAction SilentlyContinue } |
        Sort-Object FullName -Descending |
        Select-Object -First 1

    if ($foundXc8) {
        $xc8 = $foundXc8.FullName
    }
    else {
        throw "No encontre xc8-cc. Instala XC8 o agrega la carpeta bin de XC8 al PATH."
    }
}

$dfpRoot = $null
$bootloaderLocalMakefile = Join-Path $projectDir "..\BL.X\nbproject\Makefile-local-default.mk"
if (Test-Path -LiteralPath $bootloaderLocalMakefile) {
    $dfpLine = Get-Content -LiteralPath $bootloaderLocalMakefile |
        Where-Object { $_ -match "^DFP_DIR=(.+)$" } |
        Select-Object -First 1
    if ($dfpLine -match "^DFP_DIR=(.+)$") {
        $dfpRoot = $Matches[1].Trim('"')
    }
}

if (-not $dfpRoot) {
    $dfpCandidates = @(
        "C:\Program Files\Microchip\MPLABX\v*\packs\Microchip\PIC18F-Q_DFP\*",
        "C:\Program Files (x86)\Microchip\MPLABX\v*\packs\Microchip\PIC18F-Q_DFP\*",
        "$env:USERPROFILE\.mchp_packs\Microchip\PIC18F-Q_DFP\*"
    )

    $foundDfp = $dfpCandidates |
        ForEach-Object { Get-ChildItem -Path $_ -Directory -ErrorAction SilentlyContinue } |
        Sort-Object FullName -Descending |
        Select-Object -First 1

    if ($foundDfp) {
        $dfpRoot = $foundDfp.FullName
    }
    else {
        throw "No encontre el pack PIC18F-Q_DFP. Instala el DFP desde MPLAB X o abre el proyecto BL.X una vez."
    }
}

$dfpXc8 = Join-Path $dfpRoot "xc8"
if (-not (Test-Path -LiteralPath $dfpXc8)) {
    throw "No encontre la carpeta XC8 del DFP: $dfpXc8"
}

Push-Location $projectDir
try {
    $xc8Args = @(
        "-mcpu=18F47Q43",
        "-mdfp=$dfpXc8",
        "-mcodeoffset=0x3000",
        "-mrom=3000-1FFFD",
        "-maddrqual=require",
        "-mno-default-config-bits",
        "-O0",
        "-std=c99",
        "-ginhx32",
        "-Wl,-Map=dist/APP_TEST.map",
        "-o",
        "dist/APP_TEST.hex",
        "main.c"
    )

    & $xc8 @xc8Args
}
finally {
    Pop-Location
}
