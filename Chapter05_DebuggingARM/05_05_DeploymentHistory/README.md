# Debugging Azure Resource Manager: Deployment History

We will make use of the deployment history functionality in the Azure Portal to get more visibility of errors in our ARM template deployments.

## View deployment errors in Portal

Run the following commands:

```powershell
az group create --name acgarmcourse0505 --location southeastasia
az group deployment create --name "chapter05_05" --resource-group acgarmcourse0505 --template-file "./azuredeploy-error.json" --parameters environment=dev
```

Then go to Azure Portal > Resource Groups > acgarmcourse0505 > Deployments > chapter05_05.

## Clean up

```powershell
az group delete --name acgarmcourse0505 -y
```
