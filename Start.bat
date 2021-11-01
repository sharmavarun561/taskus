@echo off
:Start
color 4F
mode con:cols=65 lines=12
cls
Title WorkSpace One Install by Anil Solankey

ECHO. ************************************************************
ECHO. *							    *
ECHO. *    PLEASE MAKE SURE THAT THE SYSTEM IS DOMAIN JOINED     *
ECHO. *           AND YOU ARE LOGGED IN AS CISADMIN              *
ECHO. *							    *
ECHO. ************************************************************
ECHO.
Echo 1. Yes, the system is alredy domain joined.
ECHO.
Echo 2. Sorry, I'll join it now.
ECHO.

Set /p Choice="Please Enter your Choice "

IF %Choice%==1 GOTO CHECK
IF %Choice%==2 GOTO DOMAIN

Echo Invalid Choice: %Choice%

Pause
cls
GOTO Start

:CHECK
IF EXIST "C:\Program Files (x86)\Airwatch" (
color 0C
cls
ECHO. ************************************************************
ECHO. *							    *
ECHO. *          WorkspaceOne is already Installed!!             *
ECHO. *							    *
ECHO. ************************************************************
Timeout 15
Exit
) Else (
Goto WS1
)
:WS1
color 2F
cls
ECHO. ************************************************************
ECHO. *							    *
ECHO. *    PLEASE WAIT WHILE WORKSPACE ONE IS BEING INSTALLED    *
ECHO. *							    *
ECHO. ************************************************************

msiexec /i "%~dp0AirWatchAgent.msi" /q ENROLL=Y SERVER=ds1768.awmdm.com LGName=TaskUs USERNAME=staging PASSWORD=VMware1! ASSIGNTOLOGGEDINUSER=Y /LOG %temp%\WorkspaceONE.log >nul

color 0C
cls
ECHO. ************************************************************
ECHO. *							    *
ECHO. *                   REBOOT SCHEDULED                       *
ECHO. *							    *
ECHO. ************************************************************

PING 127.0.0.1 -n 300 >nul
TIMEOUT 60
Net user cisadmin P@ssw0rd12345!
tzutil /s "India Standard Time"
Shutdown -f -r -t 01
Exit

:DOMAIN
sysdm.cpl
Exit

