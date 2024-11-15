:: This script is used to run batch files directly from the perforce depot view, in order
:: to set it up, create a new custom tool, enable context menu, and pass arguments "%f"

@echo off

set script=%1
echo batch script: 
echo %script%

if not "%script:~-4%"==".bat" (
    echo Error: not a batch script
    exit /b 1
)

for %%A in ("%script%") do set scriptdir=%%~dpA
cd /d %scriptdir%

echo Current directory: 
echo %cd%

call %script%
echo
echo Errorlevel: %errorlevel%

pause