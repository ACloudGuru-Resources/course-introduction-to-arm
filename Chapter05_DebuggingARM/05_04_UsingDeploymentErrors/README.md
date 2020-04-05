# Debugging Azure Resource Manager: Using Deployment Errors

We will interpret deployment errors from our deployments. There is guidance on deployment errors in the [Microsoft documentation](https://docs.microsoft.com/en-us/azure/azure-resource-manager/templates/common-deployment-errors).

## View deployment errors in Portal

Run the following commands:

```powershell
az group create --name acgarmcourse0504 --location southeastasia
az group deployment create --name "chapter05_04" --resource-group acgarmcourse0505 --template-file "./azuredeploy-error.json" --parameters environment=dev
```

## Clean up

```powershell
az group delete --name acgarmcourse0504 -y
```
