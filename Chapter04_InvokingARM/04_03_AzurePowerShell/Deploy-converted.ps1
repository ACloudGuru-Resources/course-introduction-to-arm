Param (
    [string] [Parameter(Mandatory = $true)] $ResourceGroupName,
    [string] [Parameter(Mandatory = $true)] $Location,
    [string] [Parameter(Mandatory = $true)] $Environment
)

# Import the Az modules
# Could also just `Import-Module Az -Force`, but it's a bit slower
Import-Module Az.Resources -Force
Import-Module Az.Storage -Force

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
$StorageContext = New-AzStorageContext -StorageAccountName $StorageAccountName
Set-AzStorageBlobContent -File "./config.json" -Container "config" -Blob "config.json" -Context $StorageContext

# Upload the index.html file to the $web container in the storage account
# Previously: az storage blob upload -f "./index.html" --container "`$web" --name "index.html" --account-name $StorageAccountName --auth-mode key
Set-AzStorageBlobContent -File "./index.html" -Container "`$web" -Blob "index.html" -Context $StorageContext



# Enable the static website feature within the storage service
# Previously: az storage blob service-properties update --account-name $StorageAccountName --static-website  --index-document index.html --auth-mode key
Enable-AzStorageStaticWebsite -IndexDocument "index.html" -Context $StorageContext

# Previously: az storage cors add --methods GET --origins "*" --services b --account-name $StorageAccountName
# This command isn't actually needed anymore, since static-webapp.json has the CORS rules within it
# However, if we did replace it, then it would look like: 
#$corsRules = @(@{AllowedHeaders=@("*"); AllowedOrigins=@("*"); MaxAgeInSeconds=30; AllowedMethods=@("Get")})
#Set-AzStorageCORSRule -CorsRules $corsRules -ServiceType Blob -Context $StorageContext

# Output the static website URL and the command to execute to delete the environment
Write-Host "Static website URL:"
# Previously: Write-Host $(az storage account show -n $StorageAccountName -g $ResourceGroupName --query "primaryEndpoints.web" --output tsv)
Write-Host (Get-AzStorageAccount -ResourceGroupName $ResourceGroupName -Name $StorageAccountName | Select-Object PrimaryEndpoints).PrimaryEndpoints.Web
Write-Host "To remove this environment execute:"
Write-Host "> az group delete --name $ResourceGroupName -y"
