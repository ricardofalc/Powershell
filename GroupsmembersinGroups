$group = "GROUP_NAME"
$members = Get-ADGroupMember $group

foreach ($member in $members) {
  if ($member.ObjectClass -eq "group") {
    Write-Output "Members of $($member.Name):"

    $subgroupMembers = Get-ADGroupMember $member.Name
    foreach ($subgroupMember in $subgroupMembers) {
      Write-Output $subgroupMember.Name

    }
  }
}


