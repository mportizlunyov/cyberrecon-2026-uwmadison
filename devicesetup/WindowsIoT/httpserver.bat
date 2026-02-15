@echo off
:: CyberRECon 2026 UW-Madison
:: Developed by Mikhail Ortiz-Lunyov
:: February 2026
::
:: Setup script to enable and run IIS Webserver on Windows IoT
::
:: Confirm your sandbox allows file writing!

setlocal enabledelayedexpansion

:: Check if DISM.exe exists/is accessible
where dism.exe
if %ERRORLEVEL% neq 0 (
    echo DISM.exe not found or access denied.
    exit /b 1
)

:: Check for existance of IIS-WebServerRole
:: Search for "Enabled" in the DISM output
::dism.exe /online /get-featureinfo /featurename:IIS-WebServerRole | find "State : Enabled" >nul
dism.exe /online /get-featureinfo /featurename:IIS-WebServerRole | find "Enabled"

if %ERRORLEVEL% neq 0 (
    echo ENABLING: IIS-WebServerRole
    
    :: Enable features
    :: dism.exe /online /enable-feature /featurename:IIS-WebServerRole /all /quiet
    dism /online /enable-feature ^
        /featurename:IIS-WebServerRole ^
        /featurename:IIS-StaticContent ^
        /featurename:IIS-DefaultDocument ^
        /featurename:IIS-HttpErrors ^
        /all /quiet
    
    echo DONE
    
    if !ERRORLEVEL! neq 0 (
        echo Failed to enable IIS-WebServerRole. Error Code: !ERRORLEVEL!
        exit /b 1
    )
    echo ISS-WebServer enabled successfully.
) else (
    echo IIS-WebServerRole is already enabled.
)

echo Setting up IIS Webserver

:: Save current directory
SET CURRENTDIRECTORYTORESTORE=%CD%

:: Enter C:\inetpub\wwwroot
cd /d C:\inetpub\wwwroot

:: Move original files
MD "original"
move ".\*" ".\original"

cd /d %CURRENTDIRECTORYTORESTORE%
ROBOCOPY %CD% C:\inetpub\wwwroot /S

:: Refresh server
iisreset /restart

:: Print IP address of webserver
ipconfig | find "IPv4" > webip.txt
set /p WEBIP=<webip.txt
echo -------------------
echo WEBSERVER @ %WEBIP%
echo -------------------

exit /b 0