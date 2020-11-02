# Azure Resource Manager Templates: Modifying the Basic Template

By modifying from the basic template covered previously (`storage-account.json`) we can change it to reflect `storage-account-final.json` using a combination of parameters, variables and functions to give us the following benefits:

* Remove hard-coded location
* Remove hard-coded storage account name
* Allow template to be executed against multiple environments (dev, test, prod)
* Switch the storage type to use locally-redundant in non-prod environments and globally-redundant in prod

```
> az group create --name acgarmcourse --location southeastasia
> az deployment group create --name "chapter03_02" --resource-group acgarmcourse --template-file "./storage-account.json" --parameters storageAccountName=acgarmcoursestorage123 environment=dev
> az deployment group create --name "chapter03_02" --resource-group acgarmcourse --template-file "./storage-account.json" --parameters storageAccountName=acgarmcoursestorage123 environment=prod
> az group delete --name acgarmcourse -y
```
