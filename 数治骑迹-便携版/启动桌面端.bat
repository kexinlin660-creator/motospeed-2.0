@echo off
setlocal EnableExtensions
set "SCRIPT_DIR=%~dp0"
set "PROJECT_ROOT=%SCRIPT_DIR%.."
set "SOURCE_PY=E:\Anaconda\envs\MCM\python.exe"
set "UI_MAIN=%PROJECT_ROOT%\ui\main_ui.py"
set "VENDOR_DIR=%PROJECT_ROOT%\.vendor"

echo Starting desktop application...

if exist "%SOURCE_PY%" if exist "%UI_MAIN%" (
    "%SOURCE_PY%" -c "import PyQt6" >nul 2>nul
    if not errorlevel 1 (
        if exist "%VENDOR_DIR%" set "PYTHONPATH=%VENDOR_DIR%;%PYTHONPATH%"
        echo Using source desktop app with MCM environment.
        start "desktop" "%SOURCE_PY%" "%UI_MAIN%"
        exit /b 0
    )
)

for /f "usebackq delims=" %%F in (`powershell -NoProfile -ExecutionPolicy Bypass -Command "(Get-ChildItem -LiteralPath '%SCRIPT_DIR%' -Filter *.exe | Sort-Object Length -Descending | Select-Object -First 1 -ExpandProperty FullName)"`) do set "DESKTOP_EXE=%%F"

if not defined DESKTOP_EXE (
    echo Desktop executable was not found.
    pause
    exit /b 1
)

start "desktop" "%DESKTOP_EXE%"
