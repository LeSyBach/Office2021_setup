@echo off
setlocal
title Install Office LTSC 2021
set "OFFICE_SETUP_SCRIPT=%~f0"

if not exist "%~dp0setup.exe" goto missing_setup
if not exist "%~dp0Configuration.xml" goto missing_config

powershell.exe -NoProfile -Command "$identity = [Security.Principal.WindowsIdentity]::GetCurrent(); $principal = New-Object Security.Principal.WindowsPrincipal($identity); if ($principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) { exit 0 } else { exit 1 }" >nul 2>&1
if errorlevel 1 goto request_admin
goto install

:request_admin
if /i "%~1"=="--elevated" goto admin_failed
echo Please select Yes in the Windows administrator prompt.
powershell.exe -NoProfile -Command "try { Start-Process -FilePath $env:OFFICE_SETUP_SCRIPT -ArgumentList '--elevated' -Verb RunAs -ErrorAction Stop } catch { Write-Host 'Administrator access was cancelled or could not be granted.'; exit 1 }"
if errorlevel 1 goto admin_failed
exit /b 0

:install
pushd "%~dp0"
if errorlevel 1 goto folder_failed
echo Installing Office LTSC Professional Plus 2021...
echo Internet is required. Please keep this window open.
echo This uses Configuration.xml and may remove older MSI Office versions.
start "" /wait "%~dp0setup.exe" /configure "%~dp0Configuration.xml"
set "OFFICE_SETUP_RESULT=%ERRORLEVEL%"
popd
if "%OFFICE_SETUP_RESULT%"=="0" goto success
if "%OFFICE_SETUP_RESULT%"=="3010" goto restart_needed
echo.
echo Setup returned error code: %OFFICE_SETUP_RESULT%
echo Check the Office setup message for details.
pause
exit /b %OFFICE_SETUP_RESULT%

:success
echo.
echo Setup completed. Open Word - File - Account to check activation.
echo Successful installation does not guarantee successful activation.
pause
exit /b 0

:restart_needed
echo.
echo Setup completed. Restart Windows when convenient.
echo After restarting, open Word - File - Account to check activation.
pause
exit /b 3010

:missing_setup
echo ERROR: setup.exe is missing. Extract the complete downloaded ZIP first.
goto failed

:missing_config
echo ERROR: Configuration.xml is missing. Keep it beside this BAT file.
goto failed

:folder_failed
echo ERROR: Could not open the installation folder.
goto failed

:admin_failed
echo ERROR: Administrator access is required. Setup was not started.

:failed
pause
exit /b 1
