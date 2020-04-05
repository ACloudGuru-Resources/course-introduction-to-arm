# Debugging Azure Resource Manager: Using Deployment Errors

We will interpret deployment errors from our deployments. There is guidance on deployment errors in the [Microsoft documentation](https://docs.microsoft.com/en-us/azure/azure-resource-manager/templates/common-deployment-errors).

## Prep

Run the following commands:

```powershell
az group create --name acgarmcourse0504 --location southeastasia
```

## Azure CLI

```powershell
az group deployment create --name "chapter05_04_cli" --resource-group acgarmcourse0504 --template-file "./azuredeploy-error.json" --parameters environment=dev
```

## Azure PowerShell

```powershell
    Import-Module "./New-AzResourceGroupDeploymentWithErrorHandling.psm1" -Force
    New-AzResourceGroupDeploymentWithErrorHandling -Name "chapter05_04_pwsh" -ResourceGroupName acgarmcourse0504 -TemplateFile "./azuredeploy-error.json" -TemplateParameterObject @{"environment"="test"}
```

## Clean up

```powershell
az group delete --name acgarmcourse0504 -y
```
