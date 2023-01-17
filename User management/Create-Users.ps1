# Helptekst
Write-Host "This script reads a CSV file with user information and creates Active Directory accounts. The accounts will be enabled and set to force a password change on first login."

#Variabele waarden
$ouPath = "OU=MyUsers,DC=falchi,DC=lab"
$outFilePath = "C:\"
$csvPath = "C:\AD-usernames.csv"



# Aantal gebruikers berekenen
$users = Import-Csv -Path $csvPath
$userCount = ($users | Measure-Object).Count
Write-Host "The input file contains $userCount users."

# Confirmatie voor verdergaan
$confirm = Read-Host "Do you want to continue? (y/n)"
if ($confirm -ne "y") {
    Write-Host "Aborting script."
    exit
}

# Variabelen voor bijhouden van succes- en foutmeldingen
$createdCount = 0
$notCreatedCount = 0
$createdUsers = @()    #lege arraylist
$notCreatedUsers = @() #lege arraylist

# Gebruikers toevoegen
foreach ($user in $users) {
    $username = $user.samaccountname
    $firstname = $user.firstname
    $lastname = $user.lastname
    $password = ConvertTo-SecureString "F@lCH1r1c@rd0123" -AsPlainText -Force
    $FullName = $User.FirstName + " " + $User.LastName
    #Will add the domain name to @
    $domain = '@' + (Get-ADDomain).dnsroot
    $UPN = $username + "$domain"

    try {
        New-ADUser -SamAccountName $username -Name $FullName -UserPrincipalName $UPN -GivenName $firstname -Surname $lastname -AccountPassword $password -ChangePasswordAtLogon $true -Enabled $true -Path $ouPath
        $createdCount++ # Teller wanneer bovenstaande commando succesvol wordt uitgevoerd d.m.v try catch
        $createdUsers += $username
        Write-Host "Useraccount $username is succesfully created." -ForegroundColor Green
    } catch {
        $notCreatedCount++ # Teller wanneer een foutcode "gevangen" wordt door try catch.
        $notCreatedUsers += $username
        Write-Host "Useraccount $username could not be created." -ForegroundColor Red
    }
}

# Eindresultaat
Write-Host "Number of created accounts: $createdCount"
Write-Host "Number of accounts that could not be created: $notCreatedCount"

# Opslaan van gecreerde en niet-gecreerde accounts naar bestanden
$createdUsers | Out-File $outFilePath"created-accounts.txt"
$notCreatedUsers | Out-File $outFilePath"not-created-accounts.txt"
