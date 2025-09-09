# HUSTLER BOT - WINDOWS INSTALLER

Write-Host "🚀 HUSTLER BOT - WINDOWS INSTALLER" -ForegroundColor Cyan
Write-Host "===================================" -ForegroundColor Cyan

# Administrator prüfen
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Error "Bitte als Administrator ausführen!"
    Read-Host "Enter drücken zum Beenden"
    exit 1
}

# Chocolatey installieren
if (-not (Get-Command choco -ErrorAction SilentlyContinue)) {
    Write-Host "📦 Installiere Chocolatey..." -ForegroundColor Yellow
    Set-ExecutionPolicy Bypass -Scope Process -Force
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
    iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
}

# Dependencies
Write-Host "📦 Installiere Dependencies..." -ForegroundColor Blue
choco install -y git docker-desktop

# Projekt herunterladen
Write-Host "📥 Lade Hustler Bot herunter..." -ForegroundColor Blue
Set-Location $env:USERPROFILE
if (Test-Path "hustler-crypto-bot") {
    Set-Location hustler-crypto-bot
    git pull
} else {
    git clone https://github.com/username/hustler-crypto-bot.git
    Set-Location hustler-crypto-bot
}

# Environment
if (-not (Test-Path ".env")) {
    Copy-Item ".env.example" ".env"
    Write-Host "✅ Environment-Datei erstellt" -ForegroundColor Green
}

# Services starten
Write-Host "🚀 Starte Services..." -ForegroundColor Blue
docker-compose up -d

# Warten
Write-Host "⏱️ Warte auf Start (60 Sekunden)..." -ForegroundColor Yellow
Start-Sleep 60

# Abschluss
Write-Host ""
Write-Host "🎉 INSTALLATION ERFOLGREICH!" -ForegroundColor Green
Write-Host "=============================" -ForegroundColor Green
Write-Host "🌐 Web Dashboard: http://localhost:3000"
Write-Host "🔐 Demo Login: demo / demo123"

Start-Process "http://localhost:3000"
Read-Host "Enter drücken zum Beenden"
