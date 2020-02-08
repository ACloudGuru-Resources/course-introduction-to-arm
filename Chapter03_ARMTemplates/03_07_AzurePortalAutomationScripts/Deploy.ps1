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
$output = az group deployment create --name "chapter03_07_$Environment" --resource-group $ResourceGroupName --template-file ".\storage-website.json" --parameters environment=$Environment
$output

# Get the storageAccountName from the deployment output
$StorageAccountName = (ConvertFrom-Json ($output -join "`r`n")).properties.outputs.storageAccountName.value

# Create an index.html file in the current directory with a heading 1 element containing the environment name
"<h1>$Environment</h1>" > index.html

# Update the index.html file to the $web container in the storage account (where the static website files are contained)
az storage blob upload -f ".\index.html" --container "`$web" --name "index.html" --account-name $StorageAccountName

# Output the static website URL and the command to execute to delete the environment
Write-Host "Static website URL:"
Write-Host $(az storage account show -n $StorageAccountName -g $ResourceGroupName --query "primaryEndpoints.web" --output tsv)
Write-Host "To remove this environment execute:"
Write-Host "> az group delete --name $ResourceGroupName -y"
