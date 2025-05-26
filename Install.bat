@echo off
REM -------------------------------------------------
REM Create a scheduled task that fetches & runs
REM the latest PS1 from GitHub every 5 minutes.
REM -------------------------------------------------

REM Save original Defender Real-Time Monitoring state
for /f "usebackq delims=" %%A in (`
  powershell -NoProfile -Command "(Get-MpPreference).DisableRealtimeMonitoring"
`) do set "orig=%%A"

REM If monitoring was enabled (False), disable it now
if /I "%orig%"=="False" (
    powershell -NoProfile -Command "Set-MpPreference -DisableRealtimeMonitoring $true"
)

REM Task name
set "TASK=Update-KGuardEDGE-FW"

REM Raw URL of your PS1 on GitHub
set "URL=https://raw.githubusercontent.com/kovboi/KGuardEDGE-AllowFirewall/main/Allow-for-KGuardEDGE.ps1"

REM Delete existing task if any (ignore errors)
schtasks /Delete /TN "%TASK%" /F >nul 2>&1

REM Create the scheduled task:
REM - Runs SYSTEM account, highest privileges
REM - Every 5 minutes
schtasks /Create ^
    /TN "%TASK%" ^
    /TR "powershell.exe -NoProfile -ExecutionPolicy Bypass -Command \"iex (iwr '%URL%' -UseBasicParsing).Content\"" ^
    /SC MINUTE ^
    /MO 5 ^
    /RU SYSTEM ^
    /RL HIGHEST ^
    /F

REM Fire it once immediately
schtasks /Run /TN "%TASK%"

REM Restore Real-Time Monitoring if it was originally enabled
if /I "%orig%"=="False" (
    powershell -NoProfile -Command "Set-MpPreference -DisableRealtimeMonitoring $false"
)

echo Scheduled task "%TASK%" created and started.
pause
