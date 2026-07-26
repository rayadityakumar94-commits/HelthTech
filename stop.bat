@echo off
title HealthTech - Stop
color 0C

cls
echo.
echo  Stopping HealthTech servers...
echo.

for /f "tokens=5" %%p in ('netstat -ano 2^>nul ^| findstr /R ":3000 "') do taskkill /PID %%p /F >nul 2>&1
for /f "tokens=5" %%p in ('netstat -ano 2^>nul ^| findstr /R ":5000 "') do taskkill /PID %%p /F >nul 2>&1

echo  Done. All servers stopped.
echo.
timeout /t 2 /nobreak >nul
