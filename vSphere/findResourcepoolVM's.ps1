# Connect to vCenter server
Connect-VIServer -Server  10.10.11.10 

#Vraag om de klantnaam
$customerName = Read-Host "Enter the customer name"

# Get all resource pools
$resourcePools = Get-ResourcePool $customerName

#Loop door de resourcepools en toon de VMs in die resourcepool
foreach ($resourcePool in $resourcePools) {
    
    #vraag de VMs op in de resourcepool
    $VMs = Get-VM -Location $resourcePool.Name
    
    #Output de resourcepool naam
    Write-Host "Resource Pool: $($resourcePool.Name)" -ForegroundColor Yellow

    #Pak alle vm's in de resourcepool en toon alleen de naam
    $VMs = Get-VM -Location $ResourcePool | Sort-Object -Property Name
    
    #Loop door de VMs en toon de naam
    Foreach ($VM in $VMs) {
        Write-Host "  VM: $($VM.Name)"
    }
}
