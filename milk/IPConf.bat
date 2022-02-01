:: Configure
set apartment_ip=172.30.0.74
set apartment_gateway=172.30.0.1
set apartment_mask=255.255.255.0
set apartment_dns=10.20.10.5
set customs_ip=10.12.11.84
set customs_gateway=10.12.11.1
set customs_mask=255.255.255.0
set customs_dns=
set customs_dns2=
:: By Ja

if not "%1"=="am_admin" (powershell start -verb runas '%0' am_admin & exit /b)
@echo off
:BEGIN
cls
echo =======IP Config Tool======= & echo.[1] DHCP & echo.[2] Customs Department IP & echo.[3] Apartment IP
choice /N /C:123 /M "choose a number... : "%2
if errorlevel ==3 goto THREE
if errorlevel ==2 goto TWO
if errorlevel ==1 goto ONE
goto END
:THREE
netsh int ipv4 set address name="Ethernet 2" source=static address=%apartment_ip% mask=%apartment_mask% gateway=%apartment_gateway%
netsh interface ipv4 add dns "Ethernet 2" address=%apartment_dns% index=1
goto END
:TWO
netsh int ipv4 set address name="Ethernet 2" source=static address=%customs_ip% mask=%customs_mask% gateway=%customs_gateway%
netsh interface ip set dns "Ethernet 2" dhcp
goto END
:ONE
netsh interface ip set address "Ethernet 2" dhcp
netsh interface ip set dns "Ethernet 2" dhcp
:END
timeout 5