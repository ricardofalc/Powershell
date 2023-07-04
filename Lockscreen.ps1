$LockscreenPath = "C:\Users\$env:username\PCV Resources\Office - Templates\Lockscreen image\PCV Lock Screen Logo.jpg"
#Kijk of de registerwaarde bestaat
$testReg = Test-Path -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\PersonalizationCSP" -WarningAction:continue

 
#Maak de registerwaarde aan indien deze nog niet bsetaat
if ($testReg -eq $false)
{
    New-Item -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\" -Name "PersonalizationCSP" 
}

Set-ItemProperty -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\PersonalizationCSP" -Name "LockScreenImagePath" -Value $LockscreenPath
Set-ItemProperty -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\PersonalizationCSP" -Name "LockScreenImageStatus" -Value "1"
Set-ItemProperty -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\PersonalizationCSP" -Name "LockScreenImageUrl" -Value $LockscreenPath