@ECHO off
cls
:start
::: ======================================================                                                 
:::            /\                                        
::: __  __    /  \     _   _   _ __ ___     __ _   _ __  
::: \ \/ /   / /\ \   | | | | | '_ ` _ \   / _` | | '_ \ 
:::  >  <   / ____ \  | |_| | | | | | | | | (_| | | | | |
::: /_/\_\ /_/    \_\  \__, | |_| |_| |_|  \__,_| |_| |_|
:::                     __/ |                            
:::                    |___/       
:::           https://github.com/BlueXAyman
::: ======================================================
for /f "delims=: tokens=*" %%A in ('findstr /b ::: "%~f0"') do @echo(%%A
ECHO.
ECHO Server Generator Made by BlueXAyman
ECHO.
color b
ECHO NOTE: This script will generate a folder in the same directory as this script file.
ECHO.
ECHO Type 1 to Generate 1.8.9 Paper Server
ECHO Type 2 to Generate 1.19.2 Paper Server

set choice=
set /p choice=Enter: 
if not '%choice%'=='' set choice=%choice:~0,1%
if '%choice%'=='1' goto oneeight
if '%choice%'=='2' goto onetwelve
ECHO "%choice%" is not valid, try again
ECHO.
goto start

:oneeight
ECHO Generating 1.8.9 Paper Folder
if not exist "Server-1.8.9" mkdir Server-1.8.9
cd Server-1.8.9
ECHO Downloading paper-1.8.8-445.jar from https://api.papermc.io
if not exist "server.jar" curl "https://api.papermc.io/v2/projects/paper/versions/1.8.8/builds/445/downloads/paper-1.8.8-445.jar" --output server.jar
ECHO Preparing Start.bat file
if not exist "start.bat" curl "https://cdn.xayman.net/admin/start.bat" --output start.bat
if not exist "\Plugins" mkdir Plugins
goto last

:onetwelve
ECHO Generating 1.19.2 Paper Folder
if not exist "Server-1.19.2" mkdir Server-1.19.2
cd Server-1.19.2
ECHO Downloading paper-1.19.2-256.jar from https://api.papermc.io
if not exist "server.jar" curl "https://api.papermc.io/v2/projects/paper/versions/1.19.2/builds/256/downloads/paper-1.19.2-256.jar" --output server.jar
ECHO Preparing Start.bat file
if not exist "start.bat" curl "https://cdn.xayman.net/admin/1.19.2/start.bat" --output start.bat
if not exist "\Plugins" mkdir Plugins
goto last

:last
ECHO.
color a
ECHO Do you want to start the server in this window? (Y/N) 

set choice=
set /p choice=(Y/N)?: 
if not '%choice%'=='' set choice=%choice:~0,1%
if /I '%choice%'=='Y' goto eula
if /I '%choice%'=='N' goto end
ECHO "%choice%" is not valid, try again
ECHO.
goto last

:eula
ECHO.
color a
ECHO Do you accept the EULA? (Y/N)

set choice=
set /p choice=(Y/N)?: 
if not '%choice%'=='' set choice=%choice:~0,1%
if /I '%choice%'=='Y' goto startserver
if /I '%choice%'=='N' goto end
ECHO "%choice%" is not valid, try again
ECHO.

:startserver
ECHO Auto Accepting Eula
if not exist "eula.txt" curl "https://cdn.xayman.net/admin/eula.txt" --output eula.txt
start.bat
:end
pause