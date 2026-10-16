# install-theme.ps1 - Steam Arabic Official Theme Installer
#
# Installs the theme into Millennium's themes directory:
#   <Steam>\millennium\themes\steam-arabic-official

param(
    [string]$SteamPath = ""
)

$ErrorActionPreference = "Stop"

# Auto-detect Steam path if not provided
if ([string]::IsNullOrWhiteSpace($SteamPath)) {
    $regVal1 = Get-ItemProperty -Path "HKCU:\Software\Valve\Steam" -Name SteamPath -ErrorAction SilentlyContinue
    $regVal2 = Get-ItemProperty -Path "HKLM:\SOFTWARE\WOW6432Node\Valve\Steam" -Name InstallPath -ErrorAction SilentlyContinue
    $regVal3 = Get-ItemProperty -Path "HKLM:\SOFTWARE\Valve\Steam" -Name InstallPath -ErrorAction SilentlyContinue
    $candidates = @(
        $regVal1.SteamPath,
        $regVal2.InstallPath,
        $regVal3.InstallPath,
        "C:\Program Files (x86)\Steam",
        "D:\Program Files (x86)\Steam",
        "C:\Program Files\Steam",
        "D:\Steam"
    )
    $SteamPath = $candidates | Where-Object { $_ -and (Test-Path $_) } | Select-Object -First 1
}

if (-not $SteamPath -or -not (Test-Path $SteamPath)) {
    throw "Steam directory not found. Please provide -SteamPath explicitly: .\install-theme.ps1 -SteamPath 'C:\Program Files (x86)\Steam'"
}

$themesDir = Join-Path $SteamPath "millennium\themes"
if (-not (Test-Path $themesDir)) {
    New-Item -ItemType Directory -Force -Path $themesDir | Out-Null
}

$themeName = "steam-arabic-official"
$destination = Join-Path $themesDir $themeName
$source = Split-Path -Parent $MyInvocation.MyCommand.Path

Write-Host "Installing Steam Arabic Official Theme to $destination..." -ForegroundColor Cyan
New-Item -ItemType Directory -Force -Path $destination | Out-Null

$files = @(
    "skin.json",
    "libraryroot.custom.css",
    "friends.custom.css",
    "webkit.custom.css",
    "theme.js"
)

foreach ($f in $files) {
    Copy-Item (Join-Path $source $f) (Join-Path $destination $f) -Force
    Write-Host "  Copied $f" -ForegroundColor Green
}

Write-Host "Steam Arabic Official Theme installed successfully!" -ForegroundColor Green
Write-Host "To enable it: Open Steam -> Settings -> Themes -> Select 'Steam Arabic Official (RTL)'." -ForegroundColor Yellow
