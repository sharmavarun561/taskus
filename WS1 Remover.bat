@ECHO OFF

Title Workspace One Remover by Anil Solankey
Color 9F
mode con: cols=65 lines=6

ECHO.
ECHO ---------------------------------------------------------------
ECHO         Please wait while Workspace One is being removed...
ECHO ---------------------------------------------------------------

wmic product where "Name like 'Workspace%%'" call uninstall /nointeractive >nul

Timeout 30 >nul

Reg Delete "HKEY_LOCAL_MACHINE\SOFTWARE\AIRWATCH" /f >nul
Reg Delete "HKEY_LOCAL_MACHINE\SOFTWARE\AirWatchMDM" /f >nul
Reg Delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Enrollments" /f >nul

RD /S /Q "C:\Windows\System32\GroupPolicy" >nul
RD /S /Q "C:\Windows\System32\GroupPolicyUsers" >nul

Net User cisadmin P@ssw0rd12345! >nul

:Reboot
cls
mode con: cols=50 lines=6
Color 4E
ECHO.
ECHO ------------------------------------------------
ECHO         Your system will reboot now...
ECHO ------------------------------------------------

Timeout 3 >nul
Shutdown -f -r -t 01

Exit 