

function loadParameters(){

param(
    [parameter(mandatory = $true)][string]$hostpoolName,
    [parameter(mandatory = $true)][string]$snapshotName,
    [parameter(mandatory = $true)][string]$localPublicIp
)
}

