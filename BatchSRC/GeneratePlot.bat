@echo off
setlocal enabledelayedexpansion

if %1=="" (
    exit
)

if %2=="" (
    exit
)

if %3=="" (
    exit
)

echo GENERATING FILE %1...
py "GeneratePlot.py" "%~1" "%2" "%3"
echo completed


endlocal