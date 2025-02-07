@echo off
setlocal enabledelayedexpansion

if %1=="" (
    exit /b 1
)

if %2=="" (
    exit /b 1
)

if not exist OUT\ (
	mkdir OUT
)

py "CalculateArea.py" "%~1" "%~2"
endlocal