# Connect to vCenter server
Connect-VIServer -Server  10.10.11.10 

$VMs = Get-VM 

Foreach ($VM in $VMs) {
    $snapshot= Get-Snapshot -VM $VM
    if ($snapshot) {
    Write-Host "VM: $($VM.Name) Snapshot: $($snapshot.Name)"
    }
}
