@echo off
set PPATH="C:\YOUR_PUTTY_PATH"
set SEV=SERVER_NAME
set USR=USER_NAME
set LKEY=private.ppk
set PCMDS=post_login_cmds.txt
cd %PPATH%
putty.exe -ssh %USR%@%SEV% -i %LKEY% -m %PCMDS%