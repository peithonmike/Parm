net use m: /delete
net use n: /delete
	
net use m: \\srv03.asp.rzne.de\ftp$\ka\sopart\avor\export /persistent:no
net use n: \\srv03.asp.rzne.de\qaspka$\daten\apps\sopart\avor\export  /persistent:no

c:\programme\robocopy\robocopy.exe n:\ m:\ sopart_export_an_kasse.txt /R:2 /W:10 /LOG:m:\roboexp.txt

N:
IF NOT EXIST sopart_export_an_kasse.txt goto Ende
IF EXIST sicher5.txt del sicher5.txt
IF EXIST sicher4.txt ren sicher4.txt sicher5.txt
IF EXIST sicher3.txt ren sicher3.txt sicher4.txt
IF EXIST sicher2.txt ren sicher2.txt sicher3.txt
IF EXIST sicher1.txt ren sicher1.txt sicher2.txt
ren sopart_export_an_kasse.txt sicher1.txt

M:
call Transpid.bat
C:

:Ende
net use m: /delete
net use n: /delete
