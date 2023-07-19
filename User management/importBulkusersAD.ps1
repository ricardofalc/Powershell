#Checks if required module is not installed, if not installed installs it.
If (!(Get-module ActiveDirectory )) {
    Import-Module ActiveDirectory
    Clear-Host
    }

#Store the data from users.csv in the $Users variable
$Users = Import-csv c:\random-employees.csv ","

$userOU = "OU=MyUsers,DC=falchi,DC=lab"

#Verbose will be shown, verbose shows what is being done.
$VerbosePreference = "Continue"
# Will add the domain name to @
$dnsroot = '@' + (Get-ADDomain).dnsroot

ForEach($User in $Users) {
    
    #Makes everything lowercase
    $FirstName = $User.FirstName.substring(0,1).toupper()+$User.FirstName.substring(1).tolower()
    $LastName  = $User.LastName.substring(0,1).toupper()+$User.LastName.substring(1).tolower()
    
    #Combines the First and Lastname for the full name.
    $FullName = $User.FirstName + " " + $User.LastName
    
    #Converts first and lastname to SamAccountName: Ricardo Falchi will be Ricardo.Falchi
    $Sam=$User.FirstName + "." + $User.LastName 
    
    #Creates standard password for user creation
    $Password = (ConvertTo-SecureString -AsPlainText 'P@ssw0rd@123' -Force)
       
    # Initializes the UPN to SAM@DOMAIN
    $UPN = $SAM + "$dnsroot"

    # OU where the user will be created
    $Department = $User.Department

    # Like uses Pattern matching, according to: https://docs.microsoft.com/nl-nl/powershell/scripting/learn/deep-dives/everything-about-if?view=powershell-7.2
    # Not case sensitive
    # ? Matches 1 character
    # * Matches amount of characters
    # So Department matching the word sales will get put in the Sales Finance OU
if ( $Department -like '*Sales*') 
{
    $OU=$userOU
    
} # Or Department matching Finance will also get put in the Sales Finance OU
elseif ( $Department -like '*Finance*') 
{
    $OU=$userOU 
} 
else { #Else the user will be thrown in to the regular OU
    $OU=$userOU
}
    #Configures email
    $email=$Sam + "$dnsroot"

    # users properties 
    if (!(get-aduser -Filter {samaccountname -eq "$SAM"})){
        $Properties = @{
       'SamAccountName'        = $Sam
       'UserPrincipalName'     = $UPN 
       'Name'                  = $Fullname
       'EmailAddress'          = $Email
       'Department'            = $Department
       'GivenName'             = $FirstName 
       'Surname'               = $Lastname  
       'AccountPassword'       = $password 
       'ChangePasswordAtLogon' = $true #User has to Change password on first logon
       'Enabled'               = $true #User accounts is enabled 
       'Path'                  = $OU
       'PasswordNeverExpires'  = $False
   }
   
   #Creates a user with all the properties in $Properties
   New-ADUser @Properties
        Write-Verbose "Succesfully created $FullName "
       }
    }
        
