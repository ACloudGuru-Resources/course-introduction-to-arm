#!/bin/bash

ResourceGroupName=$1
Location=$2
Environment=$3

# Change current directory to the same folder as this script
cd "${0%/*}"

# Create a resource group with the name and location passed into the script
az group create --name $ResourceGroupName --location $Location

# Deploy the ARM template to the resource group
output=$(az group deployment create --name "chapter03_09_${Environment}" --resource-group $ResourceGroupName --template-file "./static-webapp.json" --parameters environment=$Environment 2>&1)
echo $output

# Get the storageAccountName from the deployment output
StorageAccountName=$(sed -nE 's/.*storageAccountName":\s*\{\s*"type":\s*"String",\s*"value":\s*"([^"]+)".+/\1/p' <<< $output)
ContainerUrl=$(sed -nE 's/.*configUrl":\s*\{\s*"type":\s*"String",\s*"value":\s*"([^"]+)".+/\1/p' <<< $output)
ConfigUrl="${ContainerUrl}/config.json"

# Create a config.json and index.html file in the current directory
ConfigTemplate=$(cat "./config-template.json")
echo ${ConfigTemplate/\{environment\}/$Environment} > ./config.json
IndexTemplate=$(cat "./index-template.html")
echo ${IndexTemplate/\{configUrl\}/$ConfigUrl} > ./index.html

# Upload the config.json file to the config container in the storage account
az storage blob upload -f "./config.json" --container "config" --name "config.json" --account-name $StorageAccountName --auth-mode key

# Upload the index.html file to the $web container in the storage account
az storage blob upload -f "./index.html" --container "\$web" --name "index.html" --account-name $StorageAccountName --auth-mode key

# Enable the static website feature within the storage service
az storage blob service-properties update --account-name $StorageAccountName --static-website  --index-document index.html --auth-mode key

# Enable CORS for the storage account from the static website
az storage cors add --methods GET --origins "*" --services b --account-name $StorageAccountName

# Output the static website URL and the command to execute to delete the environment
echo "Static website URL:"
echo $(az storage account show -n $StorageAccountName -g $ResourceGroupName --query "primaryEndpoints.web" --output tsv)
echo "To remove this environment execute:"
echo "> az group delete --name $ResourceGroupName -y"
