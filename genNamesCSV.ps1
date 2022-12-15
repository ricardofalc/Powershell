# Define the number of rows to generate and output path
$numRows = 10
$outputPath = "c:\random-employees.csv"

# Define the possible values for FirstName, LastName, and Department
$firstNames = @("Ricardo", "Bumper", "Henk", "Kees", "Koos", "Jan", "Frits", "Tina", "Juultje", "Emily", "Booboo", "Twink", "Binky", "Monkey", "Michiel", "Peter", "Jelle", "Anna", "Marieke", "Wouter", "Lisa", "Sanne", "Benjamin", "Sophie")
$lastNames = @("Falchi", "Koolhaas", "Friet", "Pannenkoek", "Knol", "Baratheon", "Aambei", "Doofus", "Bumstead", "Poopins", "Stark", "Dweeb", "Nitwit", "Hangcock", "Janssen", "Visser", "De Boer", "Smit", "De Vries", "Van den Berg", "Vermeulen", "Van der Meer", "De Jong", "Bakker")
$departments = @("Sales", "Marketing", "IT", "HR", "Finance", "Operations", "Verzaak", "Legal", "Customer Service", "Engineering")

# Create a new array to store the generated rows
$rows = @()

# Generate the specified number of rows
for ($i = 0; $i -lt $numRows; $i++) {
  # Generate random values for the FirstName, LastName, and Department fields
  $firstName = $firstNames | Get-Random
  $lastName = $lastNames | Get-Random
  $department = $departments | Get-Random

  # Create a new object to represent the row, and add it to the array of rows
  $row = New-Object -TypeName PSObject
  $row | Add-Member -MemberType NoteProperty -Name "FirstName" -Value $firstName
  $row | Add-Member -MemberType NoteProperty -Name "LastName" -Value $lastName
  $row | Add-Member -MemberType NoteProperty -Name "Department" -Value $department
  $rows += $row
}

# Export the array of rows to a CSV file
$rows | Export-Csv -Path $outputPath -NoTypeInformation