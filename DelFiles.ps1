===================================================

# Autor: Daniel Knaup
# Datum: 10.01.2013
# Thema: Script zum "Recyceln von Backup-Dateien

# Hier wird der Pfad der Backupdateien in die Variable "$path" geschrieben
$path="e:\dmz\vsp"
# Das aktuelle Datum wird in die Variable "$now" geschrieben
$now=date

# Hi wird das Datum bestimmt, von dem aus - im sp�teren Verlauf des Scripts - alle �lteren
# Backup-Dateien gel�scht werden. (Aktuelles Datum minus 15)
$TageAlt = (Get-Date).AddDays(-15)

# Variable "$TageAlt" wird an Varialbe "$DateiAlter" �bergeben
$DateiAlter=$TageAlt  

# Schleife auf Basis der Dateien die im Pfad "e:\dmz\vsp" abgelegt sind
Foreach ($item in (dir $path))
{ 
	# Abfrage, ob das Objekt das gel�scht werden soll, kein Ordner ist
	If (!( $item.PSIsContainer))         
	{   
		# Abfrage ob das �nderungsdatum der aktuellen Datei kleiner ist(<) als das Datum,
		# welches in der Variable "$DateiAlter" zuvor gespeichert wurd
        If ($item.LastWriteTime �lt $DateiAlter)  
        {     
			# Zu dem Log-File wird das aktuelle Datum hinzugef�gt
			Add-Content e:\dmz\delete-backup.log $now
			# Zu dem Log-File wird der vollst�ndig Name der Datei hinzugef�gt,
			# die im folgenden gel�scht werden soll
			Add-Content e:\dmz\delete-backup.log "$item.FullName`n `n"
			# Die Datei wird gel�scht; die Angabe des vollst�ndigen Pfadnamens
			# ist hier erforderlich
            Remove-Item $item.FullName
        }
		
	}

}