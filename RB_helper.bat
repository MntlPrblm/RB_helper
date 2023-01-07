@echo off
cls
title Windows Automation helper
color f
echo changing directory...
cd c:\Users\%USERNAME%\Desktop
timeout /T 1 /NOBREAK >NUL
echo           wake up, %username% ...
echo        the matrix has you
echo      follow the white rabbit.
echo.
echo          knock, knock, %username%.
echo.
echo                        (`.         ,-,
echo                        ` `.    ,;' ^/
echo                         `.  ,'^/ .'
echo                          `. X ^/.'
echo                .-;--''--.._` ` (
echo              .'            ^/   `
echo             ,           ` '   Q '
echo             ,         ,   `._    ^\
echo          ,.^|         '     `-.;_'
echo          :  . `  ;    `  ` --,.._;
echo          ' `    ,   )   .'
echo              `._ ,  '   ^/_
echo                 ; ,''-,;' ``-
echo                  ``-..__``--`
echo.
echo Loading...
timeout /T 1 /NOBREAK >NUL
goto checks

:checks
echo checking...
if exist "C:\Users\%USERNAME%\Desktop\windowshelp" (
  color a && echo Directory Exists
) else (
  color 4 && echo Directory does not exist && echo creating directory... && mkdir windowshelp
)
timeout /T 2 /NOBREAK>NUL
cd windowshelp
IF EXIST conv.txt del /f conv.txt
echo Windows helper started>>conv.txt
set rsp=Version 1.0
goto start

:start
echo %rsp%>>conv.txt
cls
color f
cd c:\Users\%USERNAME%\Desktop\windowshelp
echo ======================================
echo For Raeghan, created by mntlprblm 2023
echo ======================================
echo OPTIONS
ECHO [1] Check Wifi Connection
ECHO [2] Delete all cookies
ECHO [3] Fix broken tasks
ECHO [4] Get MAC ADDRESS
ECHO [5] Get NETWORK info
ECHO ------------------
echo COMMANDS
echo [6] Delete Temp files
echo [7] SHUTDOWN
echo [8] Show WIFI password
echo [9] ADVANCED NETWORK STATS
echo [0] exit
echo ==================
echo TERMINAL OUTPUT
type conv.txt
echo ==================
echo.
set /p "in=Input: "
echo "%in%">>conv.txt
if "%in%"=="1" echo checking wifi && goto check
if "%in%"=="2" echo Deleting cookies... && goto clearhistory
if "%in%"=="3" echo Entering task mode... && goto fix
if "%in%"=="4" echo Getting MAC... && goto getmac
if "%in%"=="5" echo Scanning network && goto ipconfig
if "%in%"=="6" echo Freeing Storage... && goto temp
if "%in%"=="7" goto shutdown
if "%in%"=="8" goto netpass
if "%in%"=="9" goto stats
if "%in%"=="0" del /f conv.txt && exit /b
echo invalid option LOL
timeout /T 2 /NOBREAK>NUL
goto start

:check
echo checking network connection...
set ip=1.1.1.1
PING -n 1 %ip%
IF ERRORLEVEL 1 set ip=down
IF "%ip%"=="down" set rsp=Wifi connection NOT FOUND && goto start
set rsp=Wifi connection FOUND && goto start

:clearhistory
set ChromeDir=C:\Users\%USERNAME%\AppData\Local\Google\Chrome\User Data
del /q /s /f "%ChromeDir%"
rd /s /q "%ChromeDir%"
RunDll32.exe InetCpl.cpl,ClearMyTracksByProcess 255
set rsp=History cleared
goto start

:fix
echo scanning tasks...
PING localhost -n 3 >NUL
echo killing tasks...
PING localhost -n 3 >NUL
taskkill /f /fi "status eq not responding"
set rsp=Non responding tasks killed
goto start

:getmac
cls
echo Harvesting...
getmac /v /fo list
pause
set rsp=MAC found
goto start

:ipconfig
ipconfig
pause
set rsp=Ip info showed
goto start

:temp
echo To free up space, you can also delete files in the downloads folder :)
echo deleting files...
timeout /T 1 /NOBREAK >NUL
cd /D %temp%
for /d %%D in (*) do rd /s /q "%%D"
del /f /q *
cd c:\Users\%USERNAME%\Desktop\windowshelp
timeout /T 1 /NOBREAK>NUL
set rsp=files deleted
goto start

:shutdown
set rsp=shutting down...
shutdown /s /f /t 0
goto start 

:netpass
setlocal enabledelayedexpansion
for /f "tokens=2delims=:" %%a in ('netsh wlan show profile ^|findstr ":"') do (
    set "ssid=%%~a"
    call :getpwd "%%ssid:~1%%"
)
:getpwd
set "ssid=%*"
for /f "tokens=2delims=:" %%i in ('netsh wlan show profile name^="%ssid:"=%" key^=clear ^| findstr /C:"Key Content"') do set pass=%%i
echo %ssid% >> conv.txt
set rsp=%pass%
goto start

:stats
ipconfig/all
pause
goto start

::EOF
goto start
