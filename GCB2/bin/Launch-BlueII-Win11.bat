@echo off
setlocal

set SCRIPT_DIR=%~dp0

where powershell >NUL 2>NUL
if errorlevel 1 (
  echo [GCB2] PowerShell not found. Launching game without prerequisite checks.
) else (
  echo [GCB2] Running Windows 11 prerequisite checks...
  powershell -NoProfile -ExecutionPolicy Bypass -File "%SCRIPT_DIR%Windows11-Prerequisites.ps1"
)

echo [GCB2] Starting BlueII.exe
start "" "%SCRIPT_DIR%BlueII.exe"

endlocal
