# Azure Resource Manager Templates: Azure Portal Automation Scripts

We will be creating a static website using Storage that we can automatically deploy across environments by first creating it in the Azure Portal and then exporting it using the Azure Portal Automation Scripts feature to get the ARM template.

Place the template in the `storage-website.json` file and then execute the deployment PowerShell script using the below commands to execute it for a test and production environment:

```powershell
./Deploy.ps1 -ResourceGroupName acgarmsttcweb -Location southeastasia -Environment test
./Deploy.ps1 -ResourceGroupName acgarmsttcweb -Location southeastasia -Environment prod
```

You will need to add the following command to `Deploy.ps1` to enable the static website feature within the storage service:

```powershell
# Enable the static website feature within the storage service
az storage blob service-properties update --account-name $StorageAccountName --static-website  --index-document index.html
```

If you don't want to run [PowerShell on your operating system](https://docs.microsoft.com/en-us/powershell/scripting/install/installing-powershell) then you can instead read the comments in the `Deploy.ps1` file to reverse engineer for your terminal of choice.

If you want to see the final versions of the files see `Deploy-final.ps1` and `storage-website-final.json`.
