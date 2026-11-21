@echo off
setlocal
cd /d "%~dp0"
set "YTCLIPPER_PORT=8788"
set "YTCLIPPER_HOST=127.0.0.1"
set "YTCLIPPER_PUBLIC_URL=http://127.0.0.1:8788"
set "YTCLIPPER_UPDATE_CHECK=0"
set "YTCLIPPER_PYTHON=%~dp0.venv\Scripts\python.exe"
if not exist "%YTCLIPPER_PYTHON%" (
    echo Set up the Python environment using the commands in README.md.
    pause
    exit /b 1
)
echo Open http://127.0.0.1:8788/app after Hassan Yt Streming Clipper starts.
"%YTCLIPPER_PYTHON%" -m studio.server
if errorlevel 1 pause
