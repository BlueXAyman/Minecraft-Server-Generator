@ECHO off
:start
cls

ECHO.
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

:starttwo
color b
ECHO.
ECHO ==============================================================================================================
ECHO         NOTE: This script will generate a folder in the same directory as this script file.
ECHO ==============================================================================================================
ECHO.
goto versionpicker

:: version picker section

:versionpicker
ECHO Type the version number you want to download (Example "1.8.9","1.19.2" or "list" for all available versions)
ECHO.
set choice=
set /p choice=Enter: 
if /I '%choice%'=='list' goto list
if '%choice%'=='1.8.8' goto oneeight
if '%choice%'=='1.8.9' goto oneeight
if '%choice%'=='1.19.2' goto customversion
if '%choice%'=='1.9.4' goto customversion
if '%choice%'=='1.10.2' goto customversion
if '%choice%'=='1.11.2' goto customversion
if '%choice%'=='1.12.2' goto customversion
if '%choice%'=='1.13.2' goto customversion
if '%choice%'=='1.14.4' goto customversion
if '%choice%'=='1.15.2' goto customversion
if '%choice%'=='1.16.5' goto customversion
if '%choice%'=='1.17.1' goto customversion
if '%choice%'=='1.18.2' goto customversion

set border=                            !! !! !! !! !! 
set error= The version "%choice%" you entered is invalid, type "list" for list of versions.
ECHO.
goto error
:error
cls
ECHO %border%
ECHO %error%
ECHO %border%
goto starttwo

:: lists section

:list
ECHO.
ECHO Lists of available versions:
ECHO 1.8.8/1.8.9
ECHO 1.9.4
ECHO 1.10.2
ECHO 1.11.2
ECHO 1.12.2
ECHO 1.13.2
ECHO 1.14.4
ECHO 1.15.2
ECHO 1.16.5
ECHO 1.17.1
ECHO 1.18.2
ECHO 1.19.2
ECHO.
goto versionpicker

:: 1.8.9 section


:oneeight
ECHO.
ECHO What would you like to name the 1.8.9 server folder? (Leave empty for Server-1.8.9)
set name=
set /p name=Enter Folder Name: 
if '%name%'=='' set name=Server-1.8.9
ECHO.
if exist "%name%" ECHO ERROR! The Folder "%name%" already exists.. 
if exist "%name%" ECHO What would you like to do? (D=Delete and regenerate a new folder) (S=Start the existing server) (R=Make a new folder with new name)
if exist "%name%" ECHO.
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
ECHO "%choice%" is not valid, try again (D=Delete and regenerate a new folder) (S=Start the existing server) (R=Make a new folder with new name)
ECHO.
goto one-eight-exists

:delete-one-eight
ECHO Deleting %name% in progress...
@RD /S /Q "%name%"
goto oneeight

:: custom version section

:customversion

ECHO.
set version=%choice%
ECHO.
ECHO Searching for %version% . . .
ECHO.
ECHO Installing JREPL to download latest build for %version% "REGEX Text processor"
curl "https://raw.githubusercontent.com/BlueXAyman/Minecraft-Server-Generator/main/jrepl.bat" --output JREPL.bat
setlocal EnableExtensions 
setlocal EnableDelayedExpansion
curl "https://api.papermc.io/v2/projects/paper/versions/%version%/builds/" --output builds.txt
if exist "builds.txt" for /F "tokens=5 delims=-." %%I in ('call "jrepl.bat" "\x22" "\r\n" /XSEQ /F "builds.txt" ^| %SystemRoot%\System32\findstr.exe /R /X "paper-%version%-[0-9][0-9]*\.jar"') do if %%I GTR !MaxNumber! set "MaxNumber=%%I"
ECHO version %version% latest build is %MaxNumber%
goto choosenamecustom

:choosenamecustom
ECHO.
ECHO What would you like to name the %version% server folder? (Leave empty for Server-%version%)
set name=
set /p name=Enter Folder Name: 
ECHO.
if '%name%'=='' set name=Server-%version%
if exist "%name%" ECHO ERROR! The Folder "%name%" already exists.. 
if exist "%name%" ECHO What would you like to do? (D=Delete and regenerate a new folder) (S=Start the existing server) (R=Make a new folder with new name) (U=Update Paper and keep data)
if exist "%name%" ECHO.
if exist "%name%" goto custom-exists
if not exist "%name%" mkdir %name%
cd %name%
ECHO %name% has been created...
if not exist "server.jar" curl "https://api.papermc.io/v2/projects/paper/versions/%version%/builds/%MaxNumber%/downloads/paper-%version%-%MaxNumber%.jar" --output server.jar
ECHO Downloading Paper-%version%-%MaxNumber%.jar from https://api.papermc.io
DEL /s /f "JREPL.bat"
DEL /s /f "builds.txt"
ECHO Preparing Start.bat file
if not exist "start.bat" echo "%ProgramFiles%\Java\jdk-17.0.5\bin\java" -jar server.jar --nogui>> start.bat
if not exist "\Plugins" mkdir Plugins
goto last

:custom-exists
set choice=
set /p choice=(D/S/R/U)?:  
if not '%choice%'=='' set choice=%choice:~0,1%
if /I '%choice%'=='D' goto delete-custom
if /I '%choice%'=='S' goto last
if /I '%choice%'=='R' goto choosenamecustom
if /I '%choice%'=='U' goto updatecustom
ECHO "%choice%" is not valid, try again (D=Delete and regenerate a new folder) (S=Start the existing server) (R=Make a new folder with new name)
ECHO.
goto custom-exists

:delete-custom
ECHO Deleting %name% in progress...
@RD /S /Q "%name%"
goto onenineteen

:updatecustom
ECHO. 
ECHO Updating the server %version% in folder %name% to build:%MaxNumber% in progress...
ECHO.
cd %name%
DEL /s /f "server.jar"
curl "https://api.papermc.io/v2/projects/paper/versions/%version%/builds/%MaxNumber%/downloads/paper-%version%-%MaxNumber%.jar" --output server.jar
ECHO.
ECHO Update successful
cd "../"
ECHO.
ECHO What would you like to do now? (D=Delete and regenerate a new folder) (S=Start the existing server) (R=Make a new folder with new name) (U=Update Paper and keep data)
goto custom-exists

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
ECHO.
ECHO Thank you for using the script :D 
ECHO Good bye!
pause