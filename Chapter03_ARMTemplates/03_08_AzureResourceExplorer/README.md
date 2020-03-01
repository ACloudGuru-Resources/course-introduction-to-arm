# Azure Resource Manager Templates: Azure Resource Explorer

We will be creating a storage account and deploying a config file to it. We will use Azure Resource Explorer to understand the syntax to allow IP addresses through the firewall.

Execute the deployment PowerShell script using the below commands to execute it for a test and production environment:

```powershell
./Deploy.ps1 -ResourceGroupName acgarmstorage -Location southeastasia -Environment test
./Deploy.ps1 -ResourceGroupName acgarmstorage -Location southeastasia -Environment prod
```

You will need to modify `storage-account.json` for the script to fully complete.

If you don't want to run [PowerShell on your operating system](https://docs.microsoft.com/en-us/powershell/scripting/install/installing-powershell) then you can instead read the comments in the `Deploy.ps1` file to reverse engineer for your terminal of choice.

If you want to see the final versions of the file see `storage-account-final.json`.
