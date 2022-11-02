@ECHO off
cls
:start
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
mkdir Server-1.8.9
cd Server-1.8.9
ECHO Downloading paper-1.8.8-445.jar from https://api.papermc.io
curl "https://api.papermc.io/v2/projects/paper/versions/1.8.8/builds/445/downloads/paper-1.8.8-445.jar" --output server.jar
goto end

:onetwelve
ECHO Generating 1.19.2 Paper Folder
goto end

:end
pause