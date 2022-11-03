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

:: version picker section


ECHO Type 1 to Generate 1.8.9 Paper Server
ECHO Type 2 to Generate 1.19.2 Paper Server

set choice=
set /p choice=Enter: 
if not '%choice%'=='' set choice=%choice:~0,1%
if '%choice%'=='1' goto oneeight
if '%choice%'=='2' goto onenineteen
ECHO "%choice%" is not valid, try again
ECHO.
goto start

:: 1.8.9 section


:oneeight
ECHO.
ECHO What would you like to name the 1.8.9 server folder? (Leave empty for Server-1.8.9)
set name=
set /p name=Enter Folder Name: 
if '%name%'=='' set name=Server-1.8.9
ECHO Generating 1.8.9 Paper Folder
if exist "%name%" ECHO The Folder "%name%" already exists.. (D=Delete and regenerate a new folder) (S=Start the existing server) (R=Make a new folder with new name)
if exist "%name%" goto one-eight-exists
if not exist "%name%" mkdir %name%
cd %name%
ECHO %name% has been created...
ECHO Downloading paper-1.8.8-445.jar from https://api.papermc.io
if not exist "server.jar" curl "https://api.papermc.io/v2/projects/paper/versions/1.8.8/builds/445/downloads/paper-1.8.8-445.jar" --output server.jar
ECHO Preparing Start.bat file
if not exist "start.bat" echo java -jar server.jar>> start.bat
if not exist "\Plugins" mkdir Plugins
goto last

:one-eight-exists
set choice=
set /p choice=(D/S/R)?:  
if not '%choice%'=='' set choice=%choice:~0,1%
if /I '%choice%'=='D' goto delete-one-eight
if /I '%choice%'=='S' goto last
if /I '%choice%'=='R' goto oneeight
ECHO "%choice%" is not valid, try again
ECHO.
goto one-eight-exists

:delete-one-eight
@RD /S /Q "%name%"
goto oneeight

:: 1.19.2 section

:onenineteen
ECHO.
ECHO What would you like to name the 1.19.2 server folder? (Leave empty for Server-1.19.2)
set name=
set /p name=Enter Folder Name: 
if '%name%'=='' set name=Server-1.19.2
ECHO Generating 1.19.2 Paper Folder
if exist "%name%" ECHO The Folder "%name%" already exists.. (D=Delete and regenerate a new folder) (S=Start the existing server) (R=Make a new folder with new name)
if exist "%name%" goto one-nineteen-exists
if not exist "%name%" mkdir %name%
cd %name%
ECHO %name% has been created...
ECHO Downloading paper-1.19.2-256.jar from https://api.papermc.io
if not exist "server.jar" curl "https://api.papermc.io/v2/projects/paper/versions/1.19.2/builds/256/downloads/paper-1.19.2-256.jar" --output server.jar
ECHO Preparing Start.bat file
if not exist "start.bat" echo "%ProgramFiles%\Java\jdk-17.0.5\bin\java" -jar server.jar --nogui>> start.bat
if not exist "\Plugins" mkdir Plugins
goto last

:one-nineteen-exists
set choice=
set /p choice=(D/S/R)?:  
if not '%choice%'=='' set choice=%choice:~0,1%
if /I '%choice%'=='D' goto delete-one-nineteen
if /I '%choice%'=='S' goto last
if /I '%choice%'=='R' goto onenineteen
ECHO "%choice%" is not valid, try again
ECHO.
goto one-nineteen-exists

:delete-one-nineteen
@RD /S /Q "%name%"
goto onenineteen


:: start server & eula promt


:last
ECHO.
color a
if not exist "start.bat" cd %name%
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
if not exist "eula.txt" echo eula=true>> eula.txt
start.bat
:end
pause