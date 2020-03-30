# Debugging Azure Resource Manager: Debug Logging

We will make use of the verbose output and debug logging functionality to get more visibility of our ARM template deployments in both Azure CLI and Azure PowerShell.

To get verbose output with Azure CLI we will be using an open source ["show deployment" Azure CLI extension](https://github.com/stuartleeks/az-cli-extension-show-deployment).

## Prep

```powershell
> az group create --name acgarmcourse0502 --location southeastasia
> az extension add --source https://azclishowdeployment.blob.core.windows.net/releases/dist/show_deployment-0.0.7-py2.py3-none-any.whl
```

## Verbose Output

### Azure CLI

```powershell
> az group deployment create --name "chapter05_03" --resource-group acgarmcourse0502 --template-file "./azuredeploy.json" --parameters environment=dev --no-wait
> az group deployment watch --resource-group acgarmcourse0502
```

### Azure PowerShell

```powershell
New-AzResourceGroupDeployment -Name "chapter05_03" -ResourceGroupName acgarmcourse0502 -TemplateFile "./azuredeploy.json" -TemplateParameterObject @{"environment"="test"} -Verbose
```

## Debug Logging

### Azure CLI

```powershell
> az group deployment create --name "chapter05_03" --resource-group acgarmcourse0502 --template-file "./azuredeploy-error.json" --parameters environment=dev --debug > output-cli.txt
```

### Azure PowerShell

```powershell
New-AzResourceGroupDeployment -Name "chapter05_03" -ResourceGroupName acgarmcourse0502 -TemplateFile "./azuredeploy-error.json" -TemplateParameterObject @{"environment"="test"} -DeploymentDebugLogLevel All
```

## Clean up

```powershell
> az group delete --name acgarmcourse0502 -y
```
