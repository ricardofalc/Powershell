$shell = New-Object -ComObject WScript.Shell

#OK
$shell.Popup("Hello World!", 0, "Window Title", 0)

#OK / Cancel
$shell.Popup("Hello World!", 0, "Window Title", 0x1)

#Abort
$shell.Popup("Hello World!", 0, "Window Title", 2)

#Question
$shell.Popup("Hello World!", 0, "Window Title", 2+32)

#Yes / No
$shell.Popup("Hello World!", 0, "Window Title", 3+32)



$answer=$shell.Popup("Hello World!", 0, "Window Title", 3+32)
switch($answer){

2{
    Write-Host "Cancel"
    break
}
6{
    Write-Host "Yes"
    break
}
7{
    Write-Host "No"
    break
}
}
```