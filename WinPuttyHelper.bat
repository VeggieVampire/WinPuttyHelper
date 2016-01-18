@echo off
REM https://github.com/VeggieVampire/WinPuttyHelper
REM set Putty local path
set PPATH="C:\YOUR_PUTTY_PATH"
REM Set the server name or IP address you wanting to connect
set SEV=SERVER_NAME
REM Set remote servers user name that will be used to connect
set USR=USER_NAME
REM Set key authentication file to login with. THIS IS NOT A PASSWORD FILE!! Use puttygen to create one and load on to remote server!!!!!
set LKEY=private.ppk
REM Set full path and filename for commands you want to run on the remote server.
set PCMDS=post_login_cmds.txt

REM start script
cd %PPATH%
putty.exe -ssh %USR%@%SEV% -i %LKEY% -m %PCMDS%
