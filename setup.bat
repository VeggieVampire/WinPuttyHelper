@echo off
set datetimef=%date:~10,4%.%date:~4,2%.%date:~7,2%
REM clear temp file
echo @echo off >temp.config.txt
cls
echo.
echo Greetings %USERNAME%,
echo 	You will be generating a script for PuTTY that will allow you to automatically login to a remote server and could even run post-login commands.
echo If this script makes you feel uncountable you can alweays hit ctrl+c
echo.
PAUSE
cls
echo Let begin.... 
echo.
echo.
echo.
SET curdir = cd
REM setup your putty path
echo Example:    C:\Putty
set /p TPPATH="Enter local path of putty:"

REM checks for path to putty is real
if exist %TPPATH%\putty.exe (
    rem file exists
	echo Putty found at your path %TPPATH%
	
	goto PGOOD
) else (
	rem file doesn't exist
    echo '%TPPATH%\putty.exe is not a real path to putty,try again'
	goto EOF
)

:PGOOD
echo.

REM Set the server name or IP address you wanting to connect

echo server name or IP address you wanting to connect?
echo "Example: 192.168.1.1 or domain"
set /p TSEV="Enter IP or remote server name:"
set tempfile=tempfile.txt
ping -n 1 %TSEV% | find "TTL">%tempfile% 

findstr /m "TTL" %tempfile%
if %errorlevel%==0 (
echo There is hope! server found
del %tempfile% 

goto SERGOOD
) else (
echo !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
echo error error error
echo No matches found for server name or IP!!!!!!!!!!!!!!!!!!!!!!!!!!!
del %tempfile%
goto EOF
)

:SERGOOD
echo. 
REM Set remote servers user name that will be used to connect
set TUSR=USER_NAME
set /p TUSR="What is the User name  for %TSEV%:"



REM checks with user if they have setup a key
SET /P ANSWER=Do you have a ssh key (Y/N)? 
echo You chose: %ANSWER% 
if /i {%ANSWER%}=={y} (goto :kyes) 
if /i {%ANSWER%}=={yes} (goto :kyes) 
goto :kno 
:kyes 
echo Example:    C:\Putty\MyCoolKey.ppk
set /p TLKEY="Set the location and file for PPK key:"


%TPPATH%\putty.exe -ssh %TUSR%@%TSEV% -i %TLKEY% -m post_login_cmds.txt
echo.
echo.
echo.
echo.
echo.
SET /P ANSWER2=Do you see the user %TUSR% repeated on the putty screen(Y/N)
if /i {%ANSWER2%}=={y} (goto :KEYPASS) 
if /i {%ANSWER2%}=={yes} (goto :KEYPASS)
 
goto :kno 

:kno 
cls
echo You pressed no or something else! 
echo You will need to generating RSA keys by using PuTTYgen on Windows for secure SSH authentication.
echo or you had issues with something else. check keys.
:EOF


:KEYPASS
echo Your key has passed!
echo Post Login Command are what you want to run on the server then exits.
SET /P ANSWER3=Do you want to run Post Login Commands (Y/N)?
if /i {%ANSWER2%}=={y} (goto :GYES) 
if /i {%ANSWER2%}=={yes} (goto :GYES) 

GOTO GNO 

:GYES
cls
echo @echo off >>WinPuttyHelper.%datetimef%.bat
echo %TPPATH%\putty.exe -ssh %TUSR%@%TSEV% -i %TLKEY% -m post_login_cmds.txt >temp.config.txt
ren temp.config.txt WinPuttyHelper.%datetimef%.bat
move %cd%\temp.config.txt %cd%\WinPuttyHelper.%datetimef%.bat

echo Your batch file is found in %cd% named WinPuttyHelper.%datetimef%.bat
echo click on WinPuttyHelper.%datetimef%.bat to login to server %TSEV% with user %TUSR%
echo to change the commands you will need to edit post_login_cmds.txt
echo %cd%\WinPuttyHelper.%datetimef%.bat
pause
GOTO :EOF

:GNO 
cls
echo @echo off >>WinPuttyHelper.%datetimef%.bat
echo %TPPATH%\putty.exe -ssh %TUSR%@%TSEV% -i %TLKEY% >temp.config.txt
dir
move %cd%\temp.config.txt %cd%\WinPuttyHelper.%datetimef%.bat

echo Your batch file is found in %cd% named WinPuttyHelper.%datetimef%.bat
echo click on WinPuttyHelper.%datetimef%.bat to login to server %TSEV% with user %TUSR%
echo %cd%\WinPuttyHelper.%datetimef%.bat
pause
GOTO :EOF

:EOF
