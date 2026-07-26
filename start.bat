

@echo off
title HealthTech
color 0A

cls
echo.
echo  ============================================================
echo    HealthTech - AI PHI/PII Redaction Platform
echo    Starting all services...
echo  ============================================================
echo.

:: Check Node.js
node --version >nul 2>&1
if errorlevel 1 (
    echo  ERROR: Node.js not found!
    echo  Download from: https://nodejs.org
    pause
    exit /b
)

for /f %%v in ('node --version') do echo  Node.js %%v detected
echo.

:: Get current directory
set ROOT=%~dp0
set FRONTEND=%ROOT%frontend
set BACKEND=%ROOT%backend

:: Install frontend deps
if not exist "%FRONTEND%\node_modules\" (
    echo  Installing frontend packages (first time only)...
    cd /d "%FRONTEND%"
    call npm install --legacy-peer-deps
    cd /d "%ROOT%"
)

:: Install backend deps
if not exist "%BACKEND%\node_modules\" (
    echo  Installing backend packages (first time only)...
    cd /d "%BACKEND%"
    call npm install
    cd /d "%ROOT%"
)

:: Kill old processes
echo  Clearing ports...
for /f "tokens=5" %%p in ('netstat -ano 2^>nul ^| findstr /R ":3000 "') do taskkill /PID %%p /F >nul 2>&1
for /f "tokens=5" %%p in ('netstat -ano 2^>nul ^| findstr /R ":5000 "') do taskkill /PID %%p /F >nul 2>&1
timeout /t 1 /nobreak >nul

:: Start Backend
echo  Starting Backend  (port 5000)...
start "Backend" cmd /k "cd /d "%BACKEND%" && node server.js"
timeout /t 3 /nobreak >nul
echo  Backend started!

:: Start Frontend
echo  Starting Frontend (port 3000)...
start "Frontend" cmd /k "cd /d "%FRONTEND%" && npm run dev"

:: Wait for frontend
echo  Waiting for frontend...
:wait
timeout /t 2 /nobreak >nul
powershell -Command "try{(New-Object Net.WebClient).DownloadString('http://localhost:3000')|Out-Null;exit 0}catch{exit 1}" >nul 2>&1
if errorlevel 1 goto wait

:: Open browser
start http://localhost:3000

cls
echo.
echo  ============================================================
echo    HEALTHTECH IS RUNNING
echo  ============================================================
echo.
echo    Website  :  http://localhost:3000
echo    API      :  http://localhost:5000/api/health
echo.
echo    DOCTOR   :  doctor@health.com  /  password
echo    ADMIN    :  admin@health.com   /  password
echo.
echo  ============================================================
echo.
echo  Press any key to close this window
pause >nul
