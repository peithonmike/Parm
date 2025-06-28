@echo on
net use N: /delete
net use R: /delete
net use Q: /delete
net use N: \\srv03.asp.rzne.de\qaspkdvz$\daten\apps /persistent:no
net use R: \\srv03.asp.rzne.de\qaspgr$\daten\apps /persistent:no
net use Q: \\srv03.asp.rzne.de\qaspkdvz$\daten\orgaeinheit /persistent:no
:: Umgebung setzen
set evtlevel=none
set PATH=%PATH%;R:\HH\HKR\VBXDLL

:: Arbeitsverzeichnis
cd /d R:\HH\hkr\work

:: Pruefen auf Dateien *.d im Applikationsverzeichnis
if exist R:\HH\HKR\*.d (
   echo.
   echo Im Verzeichnis R:\HH\HKR sind *.d Dateien
   echo.
   echo Diese muessen in das Verzeichnis R:\HH\HKR\Work verschoben werden.
   echo Informieren Sie Ihren Systemverantwortlichen.
   echo.
   pause
   goto end
)

:: Programmstart
start R:\HH\cdlc10\bin\prowin32 -ininame ..\script\hkrt32.ini -pf ..\script\hkrct32.pf -param PV=TEST,BJ=19

:end
lnotes %ERRORLEVEL%
