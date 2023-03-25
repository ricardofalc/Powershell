$path = "\\BRDN-ADF01.bordanbena.local\Shared\Homedrive"

$subdirectories = Get-ChildItem $path -Directory
$folderOwner = "admin.sigmax"


# Loop door iedere subdirectory
foreach ($subdir in $subdirectories) {
    # Krijg de ACL van de subdir
    $acl = Get-Acl $subdir.FullName
    #Veranderd eigenaar
    $acl.SetOwner([System.Security.Principal.NTAccount] $folderOwner)
    Set-Acl $subdir.FullName $acl
    #Verwijderd overgeerfde perms en onderliggende
    $acl.SetAccessRuleProtection($true,$false)
     #Update de wijziging
     Set-Acl $subdir.FullName $acl

    # Loop door iedere ACE in de ACL. Iedere ACE staat voor een object(groep/user) met rechten.
    foreach ($ace in $acl.Access) {
        # Check if the ACE is for the "Users" or "Domain users" group
        if ($ace.IdentityReference -eq "BUILTIN\Users" -or $ace.IdentityReference -eq "BORDANBENA\Domain users") {
            #Verwijder de ACE van de ACL
            $acl.RemoveAccessRule($ace)

            #Stel de aanpassing in
            Set-Acl $subdir.FullName $acl
        }
    }
}


# ACL / NTFS Perms uitgelegd in PowerShell: https://adamtheautomator.com/ntfs-permissions/

