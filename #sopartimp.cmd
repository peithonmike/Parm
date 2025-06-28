net use m: /delete
net use n: /delete

net use m: \\srv03.asp.rzne.de\ftp$\%ORT2%\sopart\avor\import /persistent:no
net use n: \\srv03.asp.rzne.de\%ftp_lw%\daten\apps\sopart\avor\import  /persistent:no

c:\programme\robocopy\robocopy.exe m: n: sopim*.* /R:2 /W:10 /LOG:m:\roboimp.txt

M:
for %%N in (sopim_*.*) do ren %%N ALT_%%N

C:
net use m: /delete
net use n: /delete

lnotes %ERRORLEVEL%