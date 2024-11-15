:: This script is used to open a p4v path directly in VS Code
:: to set it up, create a new custom tool, enable context menu, and pass arguments: "$u $c $p %d"

@echo off
setlocal

set "scriptPath=%~dp0"
powershell.exe -ExecutionPolicy Bypass -File "%scriptPath%OpenInCode.ps1" %*

endlocal
