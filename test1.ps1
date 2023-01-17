$path = "<PATH>"
$csvPath = "<CSV_FILE_PATH>"

$directories = Get-ChildItem $path -Recurse
$groupPermissions = @()

foreach($directory in $directories) {
  $acl = Get-Acl $directory.FullName
  $directoryGroups = $acl.Access | Where-Object { $_.IsInherited -eq $false } | Select-Object -ExpandProperty IdentityReference

  foreach($group in $directoryGroups) {
    $groupPermissions += [PSCustomObject]@{
      "Group" = $group.ToString()
      "Path" = $directory.FullName
      "Rights" = $acl.AccessToString
    }
  }
}

$groupPermissions | Export-Csv $csvPath -NoTypeInformation