

# Create a tag file just so Intune knows this was installed
if (-not (Test-Path "$($env:APPDATA)\Microsoft\NWmapping"))
{
    Mkdir "$($env:APPDATA)\Microsoft\NWmapping"
}
Set-Content -Path "$($env:APPDATA)\Microsoft\NWmapping\O_Schijf.tag" -Value "Installed"

# Initialization
Start-Transcript "C:\Windows\Temp\O_schijf.txt" -Append

#Make mapping
New-PSDrive -Name "O" -PSProvider "FileSystem" -Root "\\path\data01$\" -Persist

#stop Transcript
Stop-Transcript
