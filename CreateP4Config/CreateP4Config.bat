:: add as custom tool to p4v, pass in arguments "-r $r -u $u -c $c -p $p"

@echo off
setlocal

set "scriptPath=%~dp0"
powershell.exe -ExecutionPolicy Bypass -File "%scriptPath%CreateP4Config.ps1" %*

endlocal
