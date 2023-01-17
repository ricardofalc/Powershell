# Verzamel alle users met een login date die leeg is.
$users = get-aduser -filter {(lastLogon -eq 0) -and (enabled -eq $true)} | select-object Name,SamAccountName

#Geef de uitkomst weer in de terminal
$users