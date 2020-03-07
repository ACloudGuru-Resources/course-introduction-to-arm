# Invoking Azure Resource Manager: Azure PowerShell

We will deploy a static website that makes an AJAX call to a config file in a storage account as per the final lab of the previous chapter. We will be taking our PowerShell script and converting it from using the Azure CLI to using the Azure PowerShell Cmdlets.

## Installing Azure PowerShell

### Checking what you have installed

This lab will be run against the cross-platform `Az` PowerShell Cmdlets (as opposed to the older Windows only `AzureRM` PowerShell Cmdlets). If you have `AzureRM` installed then you'll need to either [install a separate PowerShell console](https://docs.microsoft.com/en-us/powershell/scripting/install/installing-powershell?view=powershell-7#powershell) or uninstall the existing `AzureRM` module. The following commands let you know if you have either `Az` or `AzureRM` already installed:

```powershell
Get-InstalledModule -Name AzureRM -AllVersions | select Name,Version
Get-InstalledModule -Name Az -AllVersions | select Name,Version
```

### Uninstalling old versions

If you need to uninstall `AzureRM` you can [follow the documentation](https://docs.microsoft.com/en-us/powershell/azure/uninstall-az-ps#uninstall-the-azurerm-module). If you have an old version of the `Az` module installed (< 3.5) then you can uninstall that by [following the documentation](https://docs.microsoft.com/en-us/powershell/azure/uninstall-az-ps#uninstall-azure-powershell-from-powershell-get).

### Installing Azure PowerShell

To install Azure PowerShell follow the [installation instructions](https://docs.microsoft.com/en-us/powershell/azure/install-az-ps).

## Lab exercise

We will change the `Deploy.ps1` file from previous labs to work against Azure PowerShell. You will likely need to use the [reference documentation](https://docs.microsoft.com/en-us/azure/azure-resource-manager/templates/deploy-powershell) to help understand the equivalent commands.

If you get stuck editing `Deploy.ps1` to use the PowerShell Cmdlets then you can reference `Deploy-final.ps1`.

Execute the deployment PowerShell script using the below commands to execute it for a test and production environment. Ensure you have logged in first using the PowerShell Cmdlets via `Connect-AzAccount`:

```powershell
./Deploy.ps1 -ResourceGroupName acgarmajax -Location southeastasia -Environment test
./Deploy.ps1 -ResourceGroupName acgarmajax -Location southeastasia -Environment prod
```
