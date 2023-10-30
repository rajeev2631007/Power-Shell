@ECHO off
cls
:start
ECHO.
ECHO 1. Change WI-FI Panipat Office
ECHO 2. 2
ECHO 3. 3
ECHO 4. DHCP
ECHO 5. Exit
set choice=
set /p choice=Type the number to print text.
if not '%choice%'=='' set choice=%choice:~0,1%
if '%choice%'=='1' goto con1
if '%choice%'=='2' goto con2
if '%choice%'=='3' goto con3
if '%choice%'=='4' goto autosearch
if '%choice%'=='5' goto end
ECHO "%choice%" is not valid, try again
ECHO.
goto start
:con1
ECHO Connecting Connection 1
netsh interface ip set address "Wi-Fi" static 192.168.1.248 255.255.255.0 192.168.1.254 1
netsh interface ipv4 set dnsservers "Wi-Fi" static 172.168.1.2 primary
netsh interface ipv4 add dnsservers "Wi-Fi" 8.8.8.8 index=2
goto end

:con2
ECHO Connecting Connection 2
ECHO obtaining auto IP
netsh interface ip set address "Wi-Fi" static 192.168.1.248 255.255.255.0 192.168.2.50 1
netsh interface ipv4 set dnsservers "Wi-Fi" static 172.168.1.2 primary
netsh interface ipv4 add dnsservers "Wi-Fi" 8.8.8.8 index=2
goto end

:con3
ECHO Connecting Connection 3
netsh interface ip set address "Wi-Fi" source=dhcp
netsh interface ip set dnsservers "Wi-Fi" source=dhcp
netsh interface ip show config "Wi-Fi"
goto end

:autosearch
ECHO obtaining auto IP
netsh interface ip set address "Wi-Fi" source=dhcp
netsh interface ip set dnsservers "Wi-Fi" source=dhcp
netsh interface ip show config "Wi-Fi"
goto end

:bye
ECHO BYE
goto end

:end
