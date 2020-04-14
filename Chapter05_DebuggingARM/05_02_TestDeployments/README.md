# Debugging Azure Resource Manager: Test Deployments

We will make use of the test deployment functionality to detect errors within an ARM template without having to execute that template in both Azure CLI and Azure PowerShell.

## Prep

```powershell
> az group create --name acgarmcourse0502 --location southeastasia
```

## Azure CLI

```powershell
> az group deployment validate --resource-group acgarmcourse0502 --template-file "./azuredeploy.json" --parameters environment=dev
```

## Azure PowerShell

```powershell
Test-AzResourceGroupDeployment -ResourceGroupName acgarmcourse0502 -TemplateFile "./azuredeploy.json" -TemplateParameterObject @{"environment"="dev"}
```

And to process the errors programmatically:

```powershell
Import-Module "./deployment-functions.psm1" -Force
$errors = Test-AzResourceGroupDeployment -ResourceGroupName acgarmcourse0502 -TemplateFile "./azuredeploy.json" -TemplateParameterObject @{"environment"="dev"}
Write-Error "Found $($errors.Length) error(s)."
Write-Error ($errors | ForEach-Object { Get-DeploymentError $_ })
```

## Clean up

```powershell
> az group delete --name acgarmcourse0502 -y
```
