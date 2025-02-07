@echo off
setlocal enabledelayedexpansion
set "FolderIN=IN"
set "FolderOUT=OUT"
set "begin=^<html^>^<head^>^<link rel=stylesheet href=styl.css^>^</head^>^<body^>^<center^>"


set "br=^<br^>"
set "hr=^<hr^>"
set "divend=^</div^>"
set "end=^</div^>^</center^>^</body^>^</html^>"

set i=0
for %%f in (%FolderIN%\*.txt) do (
    set file[!i!]=%%~nxf
    set /a i+=3
)

set j=1
for %%f in (%FolderOUT%\*.txt) do (
    set file[!j!]=%%~nxf
    set /a j+=3
)

set k=2
for %%f in (%FolderOUT%\*.txt) do (
	type "%%f">temp
	set /p file[!k!]=<temp
	set /a k+=3
	del temp
)

set /a i=%i%-1

if exist Raport.html (
	del Raport.html
)

echo %begin%>>Raport.html
echo ^<h2^>RESULTS^</h2^>%br%>>Raport.html
echo ^<h3^>%DATE% %TIME%^</h3^>>>Raport.html

set "table=^<table^>"
set "tableend=^</table^>"
set "tr=^<tr^>"
set "trend=^</tr^>"
set "td=^<td^>"
set "tdend=^</td^>"
set "th=^<th^>"
set "thend=^</th^>"

echo %table%>>Raport.html 
echo %tr%>>Raport.html
echo %th%>>Raport.html
echo FILE IN>>Raport.html
echo %thend%>>Raport.html
echo %th%>>Raport.html
echo FILE OUT>>Raport.html
echo %thend%>>Raport.html
echo %th%>>Raport.html
echo RESULT OUT>>Raport.html
echo %thend%>>Raport.html
echo %trend%>>Raport.html

echo %tr%>>Raport.html
for /l %%a in (0,1,%i%) do (
	set actual=%%a
	set /a check=!actual!%%3
	echo %td%>>Raport.html
	if !check!==0 (
		echo ^<a href=^"%FolderIN%\!file[%%a]!^"^>>>Raport.html
		echo !file[%%a]!>>Raport.html
		echo [click]^</a^>>>Raport.html
	) else if !check!==2 (
		echo !file[%%a]!>>Raport.html
	) else (
		echo ^<a href=^"%FolderOUT%\!file[%%a]!^"^>>>Raport.html
		echo !file[%%a]!>>Raport.html
		echo [click]^</a^>>>Raport.html
	)
	
	echo %tdend%>>Raport.html
	
	if !check!==2 (
		echo %br%>>Raport.html
		echo %trend%>>Raport.html
		echo %tr%>>Raport.html
	)
)
echo %trend%>>Raport.html
echo %tableend%>>Raport.html 
echo %end%>>Raport.html
start Raport.html

endlocal
