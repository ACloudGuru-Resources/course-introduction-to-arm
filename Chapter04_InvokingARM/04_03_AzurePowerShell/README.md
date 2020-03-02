# Invoking Azure Resource Manager: Azure PowerShell

We will deploy a static website that makes an AJAX call to a config file in a storage account as per the final lab of the previous chapter. We will be taking our PowerShell script and converting it from using the Azure CLI to using the Azure PowerShell Cmdlets.

If you get stuck editing `Deploy.ps1` to use the PowerShell Cmdlets then you can reference `Deploy-final.ps1`.

First you need to [install the Cmdlets](https://docs.microsoft.com/en-us/powershell/azure/install-az-ps).

Execute the deployment PowerShell script using the below commands to execute it for a test and production environment. Ensure you have logged in first using the PowerShell Cmdlets via `Connect-AzAccount`:

```powershell
./Deploy.ps1 -ResourceGroupName acgarmajax -Location southeastasia -Environment test
./Deploy.ps1 -ResourceGroupName acgarmajax -Location southeastasia -Environment prod
```
