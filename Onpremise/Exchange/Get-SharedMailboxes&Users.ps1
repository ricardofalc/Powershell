#Export path
$exportPath = "C:\temp\SharedMailboxes.csv"

# Get all shared mailboxes
$SharedMailboxes = Get-Mailbox -RecipientTypeDetails SharedMailbox

# Initialize an array to store the results
$Result = @()

foreach ($Mailbox in $SharedMailboxes) {
    $MailboxName = $Mailbox.Name
    $Permissions = Get-MailboxPermission -Identity $Mailbox.Identity | Where-Object { $_.IsInherited -eq $false -and $_.User -ne "NT AUTHORITY\SELF" } | Select-Object User, AccessRights

    foreach ($Permission in $Permissions) {
        $User = $Permission.User
        $AccessRights = $Permission.AccessRights -join ","

        # Add data to the result array
        $Result += New-Object PSObject -property @{
            "SharedMailbox" = $MailboxName
            "User" = $User
            "AccessRights" = $AccessRights
        }
    }
}

# Export the result to a CSV file
$Result | Export-Csv -Path $exportPath -NoTypeInformation
