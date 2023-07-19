# script that uses file new-accounts.csv as input
# script creates file AD-usernames.csv as output
# inputfile has just one column: name.
# Example names are John Breskens and Dirk van de Pol.
# The Outputfile had three columns: firstname, lastname and samaccountname.
# Examples are john,breskens,jbreskens and dirk,pol,dpol

# set variable names
$names=@("firstname," + "lastname," + "samaccountname")

#import comma separated file 
import-csv .\2023-08-new-accounts.csv | `

foreach-object { 
  # convert name to just first and lastname
  # Example: Dirk van de Pol has to be converted to Dirk Pol
 
  $name = $_.name -replace('\s[a-zA-Z]+\s', ' ')

  # concert characters in name to lowercase
  $name = $name.ToLower()

  Write-Output $name;

  # split string name in firstname and lastname
  $firstname,$lastname = $name.split(" ", 2)


  # set samaccountname (firstcharacter firstname + lastname)
  $samaccountname=$firstname.Substring(0,1)+$lastname

  # add firstname, lastname, samaccountname to collection $names
  $names+=$firstname + "," + $lastname + "," + $samaccountname
} 
    

 # write result (in collection $names) to outputfile (comma separated file)
 Out-file .\AD-usernames.csv -inputobject $names -force