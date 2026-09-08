@echo off
setlocal enabledelayedexpansion

:: ============================================
:: CONFIGURAÇÕES
:: ============================================
set "PORTA=COM14"
set "BAUD=9600"
set "ARQUIVO_CSV=dados_horta.csv"
set "ARQUIVO_LOG=registro_%date:~-4%-%date:~3,2%-%date:~0,2%_%time:~0,2%h%time:~3,2%min%time:~6,2%s.txt"

:: Remove espaços e caracteres inválidos do nome
set "ARQUIVO_CSV=%ARQUIVO_CSV: =0%"
set "ARQUIVO_LOG=%ARQUIVO_LOG: =0%"

:: ============================================
:: EXIBE INFORMAÇÕES
:: ============================================
cls
echo ================================================
echo         MONITORAMENTO DE HORTA MARCIANA
echo ================================================
echo.
echo  [STATUS] Preparando captura dos dados...
echo.
echo  Porta serial: %PORTA% (%BAUD% baud)
echo  Arquivo CSV : %cd%\%ARQUIVO_CSV%
echo  Arquivo LOG : %cd%\%ARQUIVO_LOG%
echo.
echo  INSTRUCOES:
echo  -----------
echo  - Pressione Ctrl+C para encerrar.
echo  - Exibindo e salvando as leituras do Arduino.
echo.
echo ================================================

:: Cria arquivo de log com informações iniciais
echo Inicio do monitoramento: %date% %time% > "%ARQUIVO_LOG%"
echo Porta: %PORTA% >> "%ARQUIVO_LOG%"
echo Arquivo de dados: %ARQUIVO_CSV% >> "%ARQUIVO_LOG%"
echo. >> "%ARQUIVO_LOG%"

:: Verifica se a porta existe
mode %PORTA% baud=%BAUD% parity=n data=8 stop=1 >nul 2>&1
if errorlevel 1 (
    echo.
    echo [ERRO] Porta %PORTA% não encontrada ou não pode ser aberta.
    echo.
    pause
    exit /b 1
)

:: ============================================
:: GERA SCRIPT POWERSHELL TEMPORÁRIO
:: ============================================
set "PS_SCRIPT=%temp%\captura_serial.ps1"
> "%PS_SCRIPT%" echo $port = New-Object System.IO.Ports.SerialPort '%PORTA%',%BAUD%,None,8,one
>> "%PS_SCRIPT%" echo $port.ReadTimeout = 5000
>> "%PS_SCRIPT%" echo $port.Open()
>> "%PS_SCRIPT%" echo Write-Host 'Conexao serial estabelecida.'
>> "%PS_SCRIPT%" echo while ($true) {
>> "%PS_SCRIPT%" echo     try {
>> "%PS_SCRIPT%" echo         $line = $port.ReadLine()
>> "%PS_SCRIPT%" echo         if ($line) {
>> "%PS_SCRIPT%" echo             # Adiciona data e horário no início da linha
>> "%PS_SCRIPT%" echo             $timestamp = Get-Date -Format "dd/MM/yyyy,HH:mm:ss"
>> "%PS_SCRIPT%" echo             $newLine = $timestamp + "," + $line
>> "%PS_SCRIPT%" echo             Write-Host $newLine
>> "%PS_SCRIPT%" echo             Add-Content -Path '%ARQUIVO_CSV%' -Value $newLine -Encoding UTF8
>> "%PS_SCRIPT%" echo         }
>> "%PS_SCRIPT%" echo     } catch {
>> "%PS_SCRIPT%" echo         Start-Sleep -Milliseconds 200
>> "%PS_SCRIPT%" echo     }
>> "%PS_SCRIPT%" echo }

:: ============================================
:: EXECUTA O SCRIPT POWERSHELL
:: ============================================
echo.
echo [OK] Porta aberta. Aguardando dados do Arduino...
echo [OK] Para encerrar, pressione Ctrl+C.
echo.

powershell -NoProfile -ExecutionPolicy Bypass -File "%PS_SCRIPT%"

:: Remove o arquivo temporário
del "%PS_SCRIPT%" >nul 2>&1

:: ============================================
:: REGISTRA O FIM DO MONITORAMENTO
:: ============================================
echo.
echo [FIM] Captura encerrada.
echo Fim do monitoramento: %date% %time% >> "%ARQUIVO_LOG%"
echo Dados salvos em: %ARQUIVO_CSV%
echo Log em: %ARQUIVO_LOG%

pause