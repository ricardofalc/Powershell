$uri="https://randomuser.me/api"

$restMethod= Invoke-RestMethod -Uri $uri -Method Get -ContentType "application/json" -Headers @{"Accept"="application/json"}


$webRequest=Invoke-WebRequest -Uri $uri -Method Get


$Result=$webRequest.Content | ConvertFrom-Json