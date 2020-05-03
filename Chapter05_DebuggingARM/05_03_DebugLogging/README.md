# Debugging Azure Resource Manager: Debug Logging

We will make use of the verbose output and debug logging functionality to get more visibility of our ARM template deployments in both Azure CLI and Azure PowerShell.

## Prep

```powershell
az group create --name acgarmcourse0503 --location southeastasia
```

## Verbose Output

We will be provisioning a template that provisions a (free tier) server farm and a storage account along with a web app on the server farm with a connection string pointing to the storage account. This template has the requisite complexity that warrants us needing a better view of what's happening while the deployment completes.

### Azure CLI (Windows only)

At time of publishing you need an extension to show verbose output during deployment in Azure CLI. We will be using an open source ["show deployment" Azure CLI extension](https://github.com/stuartleeks/az-cli-extension-show-deployment).

**Unfortunately this extension only works on Windows so if you are on another operating system you'll need to skip this bit and go to the Azure PowerShell bit.**

To install it:

```powershell
az extension add --source https://azclishowdeployment.blob.core.windows.net/releases/dist/show_deployment-0.0.7-py2.py3-none-any.whl
```

Then you can execute the following to see it:

```powershell
az group deployment create --name "chapter05_03_verbose_cli" --resource-group acgarmcourse0503 --template-file "./azuredeploy.json" --parameters environment=dev --no-wait
az group deployment watch --resource-group acgarmcourse0503 --refresh 1

```

### Azure PowerShell

```powershell
New-AzResourceGroupDeployment -Name "chapter05_03_verbose_pwsh" -ResourceGroupName acgarmcourse0503 -TemplateFile "./azuredeploy.json" -TemplateParameterObject @{"environment"="test"} -Verbose
```

## Debug Logging

We will be provisioning an erroneous template involving two storage accounts - one with invalid name, the other with an invalid 'Kind'.

### Azure CLI

```powershell
az group deployment create --name "chapter05_03_debug_cli" --resource-group acgarmcourse0503 --template-file "./azuredeploy-error.json" --parameters environment=dev --debug
```

### Azure PowerShell

```powershell
function New-AzResourceGroupDeploymentWithDebug($Name, $ResourceGroupName, $TemplateFile, $TemplateParameterObject) {
    $deploymentResult = New-AzResourceGroupDeployment -Name $Name -ResourceGroupName $ResourceGroupName -TemplateFile $TemplateFile -TemplateParameterObject $TemplateParameterObject -DeploymentDebugLogLevel All -Verbose
    $deploymentResult
    if ($deploymentResult.ProvisioningState -eq "Failed") {
        Write-Host "Deployment failed; retrieving operation details for debugging..."
        $operations = Get-AzResourceGroupDeploymentOperation -DeploymentName $Name -ResourceGroupName $ResourceGroupName
        $operations | ForEach-Object {
            Write-Host "Operation $($_.id):" -ForegroundColor Magenta
            Write-Host "Properties:" -ForegroundColor Cyan
            $_.Properties | Select-Object -Property * -ExcludeProperty Request,Response | ConvertTo-Json -Depth 10
            if ($_.Properties.Request) {
                Write-Host "Request:" -ForegroundColor Cyan
                $_.Properties.Request | ConvertTo-Json -Depth 10
            }
            if ($_.Properties.Response) {
                Write-Host "Response:" -ForegroundColor Cyan
                $_.Properties.Response | ConvertTo-Json -Depth 10
            }
        }
    }
}

New-AzResourceGroupDeploymentWithDebug -Name "chapter05_03_debug_pwsh" -ResourceGroupName acgarmcourse0503 -TemplateFile "./azuredeploy-error.json" -TemplateParameterObject @{"environment"="test"}

```

## Clean up

```powershell
az group delete --name acgarmcourse0503 -y
```
