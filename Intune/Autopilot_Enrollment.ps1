# Intune Autopilot Enrollment Script Template

# Import the Intune PowerShell module
Import-Module -Name Microsoft.Graph.Intune

# Define your Intune credentials (you can use a service principal or interactive login)
$clientId = "YOUR_CLIENT_ID"
$clientSecret = "YOUR_CLIENT_SECRET"
$tenantId = "YOUR_TENANT_ID"

# Connect to Intune
$token = Get-MgAuthenticationToken -ClientId $clientId -ClientSecret $clientSecret -TenantId $tenantId
Connect-MgGraph -AccessToken $token.AccessToken

# Define your enrollment settings
$enrollmentProfileName = "Your_Enrollment_Profile_Name"
$tenantName = "yourtenantname.onmicrosoft.com"  # Your tenant name, without "https://" and trailing "/"

# Define your hardware ID (you can use Get-WmiObject to retrieve it programmatically)
$hardwareID = "Your_Hardware_ID"

# Define your user principal name (UPN) for AutoPilot enrollment
$upn = "user@example.com"

# Check if the device is already enrolled
$device = Get-MgDevice -Filter "managedDeviceId eq '$hardwareID'"
if ($device -ne $null) {
    Write-Host "Device is already enrolled with ID: $($device.managedDeviceId)"
}
else {
    # Create an enrollment profile
    $profile = New-MgDeviceEnrollmentProfile -DisplayName $enrollmentProfileName -Description "AutoPilot Enrollment Profile" -AuthenticationType "AzureADJoin"

    # Generate an Autopilot deployment profile
    $profileJson = @"
{
    "Kind": "WindowsAutoPilotDeploymentProfile",
    "DisplayName": "$enrollmentProfileName",
    "Description": "AutoPilot Deployment Profile",
    "EnrollmentMode": "AzureADJoin",
    "DefaultProfile": false,
    "IsDefault": false,
    "Assignments": [
        {
            "@odata.type": "#microsoft.graph.windowsAutopilotDeploymentProfileAssignment",
            "target": {
                "@odata.type": "#microsoft.graph.deviceAndAppManagementAssignmentTarget",
                "deviceAndAppManagementAssignmentTarget": {
                    "deviceIds": [
                        "$hardwareID"
                    ],
                    "deviceAndAppManagementAssignmentTenant": "$tenantName"
                }
            }
        }
    ]
}
"@

    # Create the Autopilot deployment profile
    $profileObject = Invoke-MgGraphRequest -Method Post -Url "deviceManagement/windowsAutopilotDeploymentProfiles" -Body $profileJson -ContentType "application/json"

    # Get the enrollment profile assignment ID
    $profileAssignmentID = $profileObject.id

    # Assign the enrollment profile to the user
    New-MgUserAssignedDevice -DeviceId $hardwareID -UserPrincipalName $upn -DeviceEnrollmentProfileId $profileAssignmentID

    Write-Host "Enrollment profile assigned to device with ID: $hardwareID and user with UPN: $upn"
}
