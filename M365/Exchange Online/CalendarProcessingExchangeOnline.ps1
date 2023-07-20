$resources = @("resource1@domain.com", "resource2@domain.com", "resource3@domain.com", "resource4@domain.com", "resource5@domain.com")
$results = @()

foreach ($resource in $resources) {
    $calendarProcessing = Get-CalendarProcessing -Identity $resource
    $results += $calendarProcessing | Select-Object *, @{Name="Identity";Expression={$resource}}
}

$results | Export-Csv -Path "C:\Path\To\Export\File.csv" -NoTypeInformation

