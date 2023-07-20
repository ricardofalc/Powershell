# Phone number to search for
$phoneNumberToFind = ""

# Retrieve the list of users and their assigned phone numbers
$users = Get-CsOnlineUser
$foundUser = $null

foreach ($user in $users) {
    $phoneNumberAssignment = Get-CsPhoneNumberAssignment | Where-Object { $_.UserId -eq $user.ObjectId -and $_.PhoneNumber -eq $phoneNumberToFind }
    if ($phoneNumberAssignment) {
        $foundUser = $user
        break  # Exit the loop as we found the user with the phone number
    }
}

if ($foundUser) {
    Write-Host "User with phone number $phoneNumberToFind found:"
    Write-Host "UserPrincipalName (UPN): $($foundUser.UserPrincipalName)"
} else {
    Write-Host "User with phone number $phoneNumberToFind not found."
}
