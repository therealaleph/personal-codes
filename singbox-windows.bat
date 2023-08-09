:: By Aleph!  
:: t.me/therealaleph 
:: twitter.com/no_itsmyturn
@echo off
CLS
:init
setlocal DisableDelayedExpansion
set "batchPath=%~0"
for %%k in (%0) do set batchName=%%~nk
set "vbsGetPrivileges=%temp%\OEgetPriv_%batchName%.vbs"
setlocal EnableDelayedExpansion
:checkPrivileges
NET FILE 1>NUL 2>NUL
if '%errorlevel%' == '0' ( goto gotPrivileges ) else ( goto getPrivileges )
:getPrivileges
if '%1'=='ELEV' (echo ELEV & shift /1 & goto :gotPrivileges)
ECHO.
ECHO **************************************
ECHO Invoking UAC for Privilege Escalation
ECHO **************************************
ECHO Set UAC = CreateObject^("Shell.Application"^) > "%vbsGetPrivileges%"
ECHO args = "ELEV " >> "%vbsGetPrivileges%"
ECHO For Each strArg in WScript.Arguments >> "%vbsGetPrivileges%"
ECHO args = args ^& strArg ^& " "  >> "%vbsGetPrivileges%"
ECHO Next >> "%vbsGetPrivileges%"
ECHO UAC.ShellExecute "!batchPath!", args, "", "runas", 1 >> "%vbsGetPrivileges%"
"%SystemRoot%\System32\WScript.exe" "%vbsGetPrivileges%" %*
exit /B
:gotPrivileges
setlocal & cd /d %~dp0
if '%1'=='ELEV' (del "%vbsGetPrivileges%" 1>nul 2>nul  &  shift /1)
echo **************************************
echo Script by Aleph!
echo Follow me on Telegram!
echo https://t.me/therealaleph
echo **************************************
echo.
echo.
echo.
echo.
@echo off
if exist sing-box.exe (
    echo "sing-box.exe already exists, no need to download!"
    echo.
    goto :skipdownload
)
for /f %%i in ('powershell -Command "Invoke-WebRequest -Uri https://github.com/SagerNet/sing-box/releases/latest -UseBasicParsing | Select-Object -ExpandProperty BaseResponse | Select-Object -ExpandProperty ResponseUri | Select-Object -ExpandProperty AbsolutePath | Split-Path -Leaf"') do (
    set "version=%%~i"
)
set "url=https://github.com/SagerNet/sing-box/releases/download/%version%/sing-box-%version:~1%-windows-amd64.zip"
set "output=sing-box-%version:~1%-windows-amd64.zip"
set "unzipped_folder=sing-box-%version:~1%-windows-amd64"
echo Downloading file from "%url%"...
powershell -Command "$ProgressPreference = 'SilentlyContinue'; Invoke-WebRequest -Uri '%url%' -OutFile '%output%'"
echo File has been downloaded successfully!
echo Unzipping file...
powershell -command "Expand-Archive -Path '%output%' -DestinationPath .\ -Force"
echo File has been unzipped, operation complete.
echo Moving files to the current directory...
powershell -Command "Move-Item -Path '.\%unzipped_folder%\*' -Destination '.\'"
echo Files moved successfully.
echo Cleaning up...
powershell -Command "Remove-Item -Path '.\%unzipped_folder%' -Recurse -Force"
powershell -Command "Remove-Item -Path '.\%output%' -Force"
echo Clean up complete.
:skipdownload
@echo off
if exist config.json (
    echo config.json already exists!
    powershell.exe -NoLogo -NoProfile -Command Write-Host 'Use the current config.json? Answer with y or n' -ForegroundColor Green -NoNewline
    set /p choice=
    
    call :subroutine
) else (
    echo config.json does not exist!
    goto:newfile
)
goto:eof
:subroutine
    if /I "%choice%" EQU "y" (
      echo You chose yes!
      echo Using the existing config.json!
      goto:oldfile
    ) else (
        if /I "%choice%" EQU "n" (
          echo You chose no!
          goto:newfile
        ) else (
          echo Invalid choice! Please answer with y or n.
        )
    )

:newfile
powershell.exe -NoLogo -NoProfile -Command Write-Host 'Please enter the subscription URL:' -ForegroundColor Green -NoNewline
set /p url=""
powershell.exe -Command "& {Invoke-WebRequest -Uri '%url%' -OutFile config.json}"
@echo off
setlocal
set "file=config.json"
powershell -NoProfile -Command ^
    "(gc '%file%') -replace 'externalmobiel.lekdijk.online', '8.8.8.8' | Out-File -encoding ASCII '%file%'"

endlocal
:oldfile
@echo off
start sing-box.exe run
timeout /t 60 /nobreak >nul
ping -n 4 facebook.com | find "TTL=" > nul
if errorlevel 1 (
    echo.
    echo Could not reach facebook.com, something is wrong, try again!
    echo.
) else (
    echo.
    echo.
    echo **************************************
    echo You're connected!
    echo DO NOT CLOSE THE OTHER WINDOW UNLESS YOU WANT TO DISCONNECT FROM SING-BOX.
    echo You can close this window though
    echo **************************************
    echo.
    echo.
)
pause
