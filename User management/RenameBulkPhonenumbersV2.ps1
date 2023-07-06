#Finds the users in file and connect them to $user 
$users = import-csv C:\temp\phone.csv -Delimiter ";"
# For all users in user
Foreach ($user in $Users) { 
    $user;
    #Filters if the user exists and replaces Telephonenumber and Mobile Phone number with values from .csv file.
     Get-Aduser -filter * -properties Displayname | Where { 
         $_.displayname -eq $user.weergavenaam }  | set-aduser -Replace @{ 
            telephoneNumber=$user.Telefoonnummer
        }  
    Get-Aduser -filter * -properties Displayname | Where { 
            $_.displayname -eq $user.weergavenaam }  | set-aduser -Replace @{ 
                Mobile=$user.'Mobiele telefoon'
           }          
    }
