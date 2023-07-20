

# Retrieve the list of users and their assigned phone numbers
$users = Get-CsOnlineUser
foreach ($user in $users) {
    $phoneNumberAssignment = Get-CsPhoneNumberAssignment | Where-Object { $_.UserId -eq $user.ObjectId }
    if ($phoneNumberAssignment) {
        $user.UserPrincipalName, $phoneNumberAssignment.PhoneNumber
    }
}
