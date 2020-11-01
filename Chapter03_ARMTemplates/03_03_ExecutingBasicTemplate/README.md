# Azure Resource Manager Templates: Executing Basic Template

```
> az group create --name acgarmcourse --location southeastasia
> az deployment group create --name "chapter03_03" --resource-group acgarmcourse --template-file "./storage-account.json"
> az group delete --name acgarmcourse -y
```
