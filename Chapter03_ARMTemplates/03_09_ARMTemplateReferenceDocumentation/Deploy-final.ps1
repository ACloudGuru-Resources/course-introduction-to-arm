Param (
    [string] [Parameter(Mandatory = $true)] $ResourceGroupName,
    [string] [Parameter(Mandatory = $true)] $Location,
    [string] [Parameter(Mandatory = $true)] $Environment
)

# Change current directory to the same folder as this script
Set-Location $PSScriptRoot

# Create a resource group with the name and location passed into the script
az group create --name $ResourceGroupName --location $Location

# Deploy the ARM template to the resource group
$output = az group deployment create --name "chapter03_09_$Environment" --resource-group $ResourceGroupName --template-file ".\static-webapp.json" --parameters environment=$Environment
$output

# Get the storageAccountName from the deployment output
$outputs = (ConvertFrom-Json ($output -join "`r`n")).properties.outputs
$StorageAccountName = $outputs.storageAccountName.value
$ConfigUrl = $outputs.configUrl.value + "/config.json"

# Create a config.json and index.html file in the current directory
(Get-Content "config-template.json") -replace "{environment}",$Environment > config.json
(Get-Content "index-template.html") -replace "{configUrl}",$ConfigUrl > index.html

# Upload the config.json file to the config container in the storage account
az storage blob upload -f ".\config.json" --container "config" --name "config.json" --account-name $StorageAccountName

# Upload the index.html file to the $web container in the storage account
az storage blob upload -f ".\index.html" --container "`$web" --name "index.html" --account-name $StorageAccountName

# Enable the static website feature within the storage service
az storage blob service-properties update --account-name $StorageAccountName --static-website  --index-document index.html

# Enable CORS for the storage account from the static website
az storage cors add --methods GET --origins * --services b --account-name $StorageAccountName

# Output the static website URL and the command to execute to delete the environment
Write-Host "Static website URL:"
Write-Host $(az storage account show -n $StorageAccountName -g $ResourceGroupName --query "primaryEndpoints.web" --output tsv)
Write-Host "To remove this environment execute:"
Write-Host "> az group delete --name $ResourceGroupName -y"
