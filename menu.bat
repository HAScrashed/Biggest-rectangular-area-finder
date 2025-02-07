:main
@echo off
cls
echo Choose from the list
echo 1) launch script
echo 2) generate sample data
echo 3) help
echo 4) backup
echo 5) exit
set /p "opcja="
if "%opcja%"=="1" goto script
if "%opcja%"=="2" goto generate
if "%opcja%"=="3" goto info
if "%opcja%"=="4" goto back
if "%opcja%"=="5" goto ex
goto wrong

:script
set "FolderIN=IN"
set "FolderOUT=OUT"
del /F /Q "%CD%\%FolderOUT%\*.*"
@echo off
cls
for %%i in (%FolderIN%\*.txt) do (
	echo processing "%CD%\%%i"...
	call "BatchSRC\CalculateArea" "%CD%\%%i" "%CD%\%FolderOUT%\%%~ni"
	echo created "%CD%\%FolderOUT%\%%~niresult.txt"
	echo ----------
)
echo Create the raport...
call BatchSRC\Raport
echo created Raport.html
pause
goto main

:generate
cls
@echo off

set "folder=%CD%\IN\"
if not exist %folder% (
	mkdir %folder%
)
del /F /Q "%folder%\*.*"
call BatchSRC\GeneratePlot "%folder%rozm10prawd70.txt" 10 70
call BatchSRC\GeneratePlot "%folder%rozm500prawd50.txt" 500 50
call BatchSRC\GeneratePlot "%folder%rozm1000prawd35.txt" 1000 35
call BatchSRC\GeneratePlot "%folder%rozm250prawd90.txt" 250 90
call BatchSRC\GeneratePlot "%folder%rozm250prawd100.txt" 250 100
call BatchSRC\GeneratePlot "%folder%rozm250prawd80.txt" 250 80
call BatchSRC\GeneratePlot "%folder%rozm700prawd40.txt" 700 40
call BatchSRC\GeneratePlot "%folder%rozm50prawd35.txt" 50 50
call BatchSRC\GeneratePlot "%folder%rozm2000prawd0.txt" 2000 0
pause
goto main

:info
cls
@echo off
echo The script searches for the biggest RECTANGULAR area in given file,
echo file has rectangular plot with zeroes and ones, script searches for zeroes.
echo Input is the txt file with squre plot and output is calculated biggest area with its shape and location.
pause
goto main

:back
cls
set "FolderIN=IN"
set "FolderOUT=OUT"
echo Creating back-up
set dataczas=%DATE:.=-%_%TIME::=-%
set dataczas=%dataczas:,=-%
tar.exe acvf "Backup%dataczas%.zip" Raport.html %FolderIN% %FolderOUT% 2> nul
echo created back-up
pause
goto main

:wrong
echo Wrong option, choose again
pause
goto main

:ex
cls
exit /b