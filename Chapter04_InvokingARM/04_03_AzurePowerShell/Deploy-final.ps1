Param (
    [string] [Parameter(Mandatory = $true)] $ResourceGroupName,
    [string] [Parameter(Mandatory = $true)] $Location,
    [string] [Parameter(Mandatory = $true)] $Environment
)

# Import the Az module
Import-Module Az -Force

# Change current directory to the same folder as this script
Set-Location $PSScriptRoot

# Create a resource group with the name and location passed into the script
New-AzResourceGroup -Location $Location -Name $ResourceGroupName -Force

# Deploy the ARM template to the resource group
$parameters = @{environment = $Environment}
$result = New-AzResourceGroupDeployment -Name "chapter04_03_$Environment" -ResourceGroupName $ResourceGroupName -TemplateFile "./static-webapp.json" -TemplateParameterObject $parameters
$result

# Get the storageAccountName from the deployment output
$StorageAccountName = $result.Outputs.storageAccountName.value
$ConfigUrl = $result.Outputs.configUrl.value + "/config.json"

# Create a config.json and index.html file in the current directory
(Get-Content "config-template.json") -replace "{environment}",$Environment > config.json
(Get-Content "index-template.html") -replace "{configUrl}",$ConfigUrl > index.html

# Upload the config.json file to the config container in the storage account
$AccountKey = (Get-AzStorageAccountKey -ResourceGroupName $ResourceGroupName -AccountName $StorageAccountName).Value[0]
$StorageContext = New-AzStorageContext -StorageAccountName $StorageAccountName -StorageAccountKey $AccountKey
# OR, if we grant our user account BlobStorageAccess the above two lines can be replaced with:
# $StorageContext = New-AzStorageContext -StorageAccountName $StorageAccountName -ConnectedAccount
Set-AzStorageBlobContent -File "./config.json" -Container "config" -Blob "config.json" -Context $StorageContext -Force -Properties @{"ContentType"="application/json"}

# Upload the index.html file to the $web container in the storage account
Set-AzStorageBlobContent -File "./index.html" -Container "`$web" -Blob "index.html" -Context $StorageContext -Force -Properties @{"ContentType"="text/html"}

# Enable the static website feature within the storage service
Enable-AzStorageStaticWebsite -IndexDocument "index.html" -Context $StorageContext

# Output the static website URL and the command to execute to delete the environment
Write-Host "Static website URL:"
Write-Host (Get-AzStorageAccount -ResourceGroupName $ResourceGroupName -Name $StorageAccountName | Select-Object PrimaryEndpoints).PrimaryEndpoints.Web
Write-Host "To remove this environment execute:"
Write-Host "> az group delete --name $ResourceGroupName -y"
