:: Configure
set office_ip=
set office_gateway=
set office_mask=
set office_dns=
set office_dns2=
::

if not "%1"=="am_admin" (powershell start -verb runas '%0' am_admin & exit /b)
@echo off
:BEGIN
cls
echo =======IP Config Tool======= & echo.[1] DHCP & echo.[2] Fixed IP & echo.[3] Office IP
choice /N /C:123 /M "choose a number... : "%2
if errorlevel ==3 goto THREE
if errorlevel ==2 goto TWO
if errorlevel ==1 goto ONE
goto END
:THREE
netsh int ipv4 set address name="Ethernet" source=static address=%office_ip% mask=%office_mask% gateway=%office_gateway%
netsh interface ipv4 add dns "Ethernet" address=%office_dns% index=1
netsh interface ipv4 add dns "Ethernet" address=%office_dns2% index=2
goto END
:TWO
set /p IP=Enter IP Address: 
set /p Subnet=Enter Subnet mask: 
set /p Gateway=Enter Gateway IP Address: 
netsh int ipv4 set address name="Ethernet" source=static address=%IP% mask=%Subnet% gateway=%Gateway%
netsh interface ipv4 add dns "Ethernet" address=8.8.8.8 index=1
netsh interface ipv4 add dns "Ethernet" address=8.8.4.4 index=2
goto END
:ONE
netsh interface ip set address "Ethernet" dhcp
netsh interface ip set dns "Ethernet" dhcp
:END
timeout 10
