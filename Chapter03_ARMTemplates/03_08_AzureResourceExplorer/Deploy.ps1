Param (
    [string] [Parameter(Mandatory = $true)] $ResourceGroupName,
    [string] [Parameter(Mandatory = $true)] $Location,
    [string] [Parameter(Mandatory = $true)] $Environment
)

# Change current directory to the same folder as this script
Set-Location $PSScriptRoot

# Create a resource group with the name and location passed into the script
az group create --name $ResourceGroupName --location $Location

# Get current IP address
#$ip = Invoke-RestMethod http://ipinfo.io/json | Select-Object -exp ip

# Deploy the ARM template to the resource group
$output = az group deployment create --name "chapter03_08_$Environment" --resource-group $ResourceGroupName --template-file ".\storage-account.json" --parameters environment=$Environment
$output

# Get the storageAccountName from the deployment output
$StorageAccountName = (ConvertFrom-Json ($output -join "`r`n")).properties.outputs.storageAccountName.value

# Create a storage container called config
az storage container create --account-name $StorageAccountName --name "config"

# Create an config.json file in the current directory
(Get-Content "config-template.json") -replace "{environment}",$Environment > config.json

# Upload the config.json file to the config container in the storage account
az storage blob upload -f ".\config.json" --container "config" --name "config.json" --account-name $StorageAccountName

# Output the command to execute to delete the environment
Write-Host "To remove this environment execute:"
Write-Host "> az group delete --name $ResourceGroupName -y"
