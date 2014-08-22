@ECHO off
ECHO %1 Passed command is the debug/release flag
ECHO Declare paths needed, package path is cleaned at start
set project= "C:\Home\Cowrie\selectedhot.local\DesktopModules\HomeAndGardens"
set rootPath="C:\Home\Cowrie\selectedhot.local\Bin"
set package= "C:\Temp\HomeAndGardens"

ECHO Delete Existing Files from package location!  CAREFUL!!!
ECHO Y | DEL %package%\*.*

ECHO Copy resource files
XCOPY %project%\App_LocalResources\*.resx %package%

REM Copy Pages
XCOPY %project%\*.aspx %package%

REM Copy User Controls
XCOPY %project%\*.ascx %package%

REM Copy DNN File
XCOPY %project%\*.dnn %package%

REM Copy GIF
XCOPY %project%\Images\*.gif %package%

REM Copy XML File
XCOPY %project%\*.xml %package%

REM Copy TXT File
XCOPY %project%\*.txt %package%

REM Copy ZIP File
XCOPY %project%\*.zip %package%

REM Copy CSS
XCOPY %project%\*.css %package%

REM Copy JS
XCOPY %project%\*.js %package%

REM Copy fancybox
XCOPY %project%\Scripts\fancybox\*.* %package%

REM Copy SqlDataProvider files
XCOPY %project%\*.SqlDataProvider %package%

REM Copy DLL Files, note use of flag to grab debug/release depending on passed value
XCOPY %project%\obj\%1\*.dll %package%

cd %package%
"C:\Program Files\7-Zip\7z" a -tzip HomeAndGardens.zip *.*

