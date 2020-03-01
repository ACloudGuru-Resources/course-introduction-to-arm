# Azure Resource Manager Templates: ARM Template Reference Documentation

We will deploy a static website that makes an AJAX call to a config file in a storage account. We will use the ARM Template reference documentation to help discover how to configure this.

Execute the deployment PowerShell script using the below commands to execute it for a test and production environment:

```powershell
./Deploy.ps1 -ResourceGroupName acgarmajax -Location southeastasia -Environment test
./Deploy.ps1 -ResourceGroupName acgarmajax -Location southeastasia -Environment prod
```

You will need to modify `static-webapp.json` for the script to fully complete.

If you don't want to run [PowerShell on your operating system](https://docs.microsoft.com/en-us/powershell/scripting/install/installing-powershell) then you can instead read the comments in the `Deploy.ps1` file to reverse engineer for your terminal of choice.

If you want to see the final versions of the file see `static-webapp-final.json`.
