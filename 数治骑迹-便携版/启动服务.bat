@echo off
setlocal EnableExtensions
set "SCRIPT_DIR=%~dp0"
set "PROJECT_ROOT=%SCRIPT_DIR%.."
set "SOURCE_PY=E:\Anaconda\envs\MCM\python.exe"
set "BACKEND_RUN=%PROJECT_ROOT%\backend\run.py"
set "VENDOR_DIR=%PROJECT_ROOT%\.vendor"

echo Starting backend service...

if exist "%SOURCE_PY%" if exist "%BACKEND_RUN%" (
    if exist "%VENDOR_DIR%" set "PYTHONPATH=%VENDOR_DIR%;%PYTHONPATH%"
    echo Using source backend with MCM environment.
    start "backend" "%SOURCE_PY%" "%BACKEND_RUN%"
    echo Backend started. Open http://127.0.0.1:5000 in your browser.
    echo Close this window at any time. The service will keep running.
    pause
    exit /b 0
)

for /f "usebackq delims=" %%F in (`powershell -NoProfile -ExecutionPolicy Bypass -Command "(Get-ChildItem -LiteralPath '%SCRIPT_DIR%' -Filter *.exe | Sort-Object Length | Select-Object -First 1 -ExpandProperty FullName)"`) do set "BACKEND_EXE=%%F"

if not defined BACKEND_EXE (
    echo Backend executable was not found.
    pause
    exit /b 1
)

start "backend" "%BACKEND_EXE%"
echo Backend started. Open http://127.0.0.1:5000 in your browser.
echo Close this window at any time. The service will keep running.
pause
