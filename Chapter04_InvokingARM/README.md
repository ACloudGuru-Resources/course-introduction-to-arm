# Invoking Azure Resource Manager

We will deploy a static website that makes an AJAX call to a config file in a storage account as per the final lab of the previous chapter. This will be used across multiple invocation environments.

## PowerShell version

Execute the deployment PowerShell script using the below commands to execute it for a test and production environment:

```powershell
./Deploy.ps1 -ResourceGroupName acgarmajax -Location southeastasia -Environment test
./Deploy.ps1 -ResourceGroupName acgarmajax -Location southeastasia -Environment prod
```

## Bash version

Execute the deployment bash script using the below commands to execute it for a test and production environment:

```bash
chmod +x deploy.sh
./deploy.sh acgarmajaxb southeastasia test
./deploy.sh acgarmajaxb southeastasia prod
```
