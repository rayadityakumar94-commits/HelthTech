$ErrorActionPreference = "SilentlyContinue"
$root = Split-Path -Parent $MyInvocation.MyCommand.Path
$frontend = Join-Path $root "frontend"
$backend  = Join-Path $root "backend"

Clear-Host
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host "  HealthTech - AI PHI/PII Redaction Platform" -ForegroundColor White
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host ""

# Install deps if missing
if (-not (Test-Path "$frontend\node_modules")) {
    Write-Host "  Installing frontend packages (first time)..." -ForegroundColor Yellow
    Set-Location $frontend
    npm install --legacy-peer-deps
    Set-Location $root
}
if (-not (Test-Path "$backend\node_modules")) {
    Write-Host "  Installing backend packages (first time)..." -ForegroundColor Yellow
    Set-Location $backend
    npm install
    Set-Location $root
}

# Kill old processes on port 3000 and 5000
netstat -ano | Select-String ":3000 " | ForEach-Object {
    $p = ($_ -split '\s+')[-1]
    if ($p -match '^\d+$') { Stop-Process -Id ([int]$p) -Force }
}
netstat -ano | Select-String ":5000 " | ForEach-Object {
    $p = ($_ -split '\s+')[-1]
    if ($p -match '^\d+$') { Stop-Process -Id ([int]$p) -Force }
}
Start-Sleep -Seconds 1

# Start Backend in new window
Write-Host "  [1/2] Starting Backend (port 5000)..." -ForegroundColor Yellow
Start-Process powershell -ArgumentList @(
    "-NoExit",
    "-Command",
    "Set-Location '$backend'; Write-Host 'Backend Running on http://localhost:5000' -ForegroundColor Green; node server.js"
)
Start-Sleep -Seconds 3
Write-Host "  [OK] Backend started" -ForegroundColor Green

# Start Frontend in new window
Write-Host "  [2/2] Starting Frontend (port 3000)..." -ForegroundColor Yellow
Start-Process powershell -ArgumentList @(
    "-NoExit",
    "-Command",
    "Set-Location '$frontend'; Write-Host 'Frontend Running on http://localhost:3000' -ForegroundColor Cyan; npm run dev"
)

# Wait until frontend responds
Write-Host "  Waiting for Vite to be ready..." -ForegroundColor Gray
 = $false
for ($i = 0; $i -lt 20; $i++) {
    Start-Sleep -Seconds 2
    try {
        $null = Invoke-WebRequest "http://localhost:3000" -UseBasicParsing -TimeoutSec 2
        $ready = $true
        break
    } catch {}
    Write-Host "  Still loading... ($($i+1)/20)" -ForegroundColor DarkGray
}

# Open in browser
Start-Process "http://localhost:3000"

Clear-Host
Write-Host ""
Write-Host "============================================================" -ForegroundColor Green
Write-Host "  HEALTHTECH IS LIVE!" -ForegroundColor Green  
Write-Host "============================================================" -ForegroundColor Green
Write-Host ""
Write-Host "  Browser should open automatically!" -ForegroundColor White
Write-Host ""
Write-Host "  URL      :  http://localhost:3000" -ForegroundColor Cyan
Write-Host "  API      :  http://localhost:5000" -ForegroundColor Cyan
Write-Host ""
Write-Host "------------------------------------------------------------" -ForegroundColor DarkGray
Write-Host "  DOCTOR LOGIN" -ForegroundColor Yellow
Write-Host "  Email    :  doctor@health.com" -ForegroundColor White
Write-Host "  Password :  password" -ForegroundColor White
Write-Host ""
Write-Host "  ADMIN LOGIN" -ForegroundColor Yellow
Write-Host "  Email    :  admin@health.com" -ForegroundColor White
Write-Host "  Password :  password" -ForegroundColor White
Write-Host "------------------------------------------------------------" -ForegroundColor DarkGray
Write-Host ""
Write-Host "  Close the 2 server windows to stop." -ForegroundColor DarkGray
Write-Host ""
