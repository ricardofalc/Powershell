#Vraag aan gebruiker hoeveel dagen geleden gebruikers voor het laatst aangemeld moeten zijn
$amountOfDays = Read-Host "Hoeveel dagen geleden moeten gebruikers voor het laatst aangemeld zijn"

#Bepaal de datum waarop de gebruikers voor het laatst aangemeld moeten zijn
$lastLogonDate = (Get-Date).AddDays(-$amountOfDays)

#Haal gebruikers op die nog niet zijn ingelogd in de afgelopen x dagen of nooit hebben ingelogd
$users = Get-ADUser -Filter {(LastLogonDate -lt $lastLogonDate) -or -not ( lastlogontimestamp -like "*")}

#Controleer of er gebruikers zijn gevonden
if ($users) {
    #Print het aantal gevonden gebruikers en vraag om bevestiging om de gebruikers te verwijderen
    Write-Host "Er zijn $($users.Count) gebruikers die nog niet zijn ingelogd in de afgelopen $amountOfDays dagen of nog nooit zijn ingelogd:"
    $confirmation = Read-Host "Wilt u deze gebruikers verwijderen? (ja/nee)"
    if ($confirmation -eq "ja") {
        #Maak een array aan voor verwijderde en mislukte gebruikers
        $deletedUsers = @()
        $failedUsers = @()
        #Loop door elke gebruiker en verwijder deze
        foreach ($user in $users) {
            try {
                Remove-ADobject $user.DistinguishedName -Recursive -Confirm:$false
                $deletedUsers += $user.Name
            } catch {
                $failedUsers += $user.Name
            }
        }
        #Print de namen van verwijderde en mislukte gebruikers
        Write-Host "De volgende gebruikers zijn verwijderd:" -ForegroundColor Yellow
        Write-Host $deletedUsers -ForegroundColor Green
        Write-Host "De volgende gebruikers konden niet worden verwijderd:" -ForegroundColor Yellow
        Write-Host $failedUsers -ForegroundColor Red
    } else {
        #Als gebruiker niet bevestigt, stop het script
        Write-Host "Verwijderen afgebroken."
    }
} else {
    #Informeert de gebruiker dat er geen gebruikers zijn gevonden
    Write-Host "Er zijn geen gebruikers gevonden die nog niet zijn ingelogd in de afgelopen $amountOfDays dagen."
}