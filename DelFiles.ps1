===================================================

# Autor: Daniel Knaup
# Datum: 10.01.2013
# Thema: Script zum "Recyceln von Backup-Dateien

# Hier wird der Pfad der Backupdateien in die Variable "$path" geschrieben
$path="e:\dmz\vsp"
# Das aktuelle Datum wird in die Variable "$now" geschrieben
$now=date

# Hi wird das Datum bestimmt, von dem aus - im späteren Verlauf des Scripts - alle älteren
# Backup-Dateien gelöscht werden. (Aktuelles Datum minus 15)
$TageAlt = (Get-Date).AddDays(-15)

# Variable "$TageAlt" wird an Varialbe "$DateiAlter" übergeben
$DateiAlter=$TageAlt  

# Schleife auf Basis der Dateien die im Pfad "e:\dmz\vsp" abgelegt sind
Foreach ($item in (dir $path))
{ 
	# Abfrage, ob das Objekt das gelöscht werden soll, kein Ordner ist
	If (!( $item.PSIsContainer))         
	{   
		# Abfrage ob das Änderungsdatum der aktuellen Datei kleiner ist(<) als das Datum,
		# welches in der Variable "$DateiAlter" zuvor gespeichert wurd
        If ($item.LastWriteTime –lt $DateiAlter)  
        {     
			# Zu dem Log-File wird das aktuelle Datum hinzugefügt
			Add-Content e:\dmz\delete-backup.log $now
			# Zu dem Log-File wird der vollständig Name der Datei hinzugefügt,
			# die im folgenden gelöscht werden soll
			Add-Content e:\dmz\delete-backup.log "$item.FullName`n `n"
			# Die Datei wird gelöscht; die Angabe des vollständigen Pfadnamens
			# ist hier erforderlich
            Remove-Item $item.FullName
        }
		
	}

}