# Azure Resource Manager Principles: Executing ARM Using the Azure CLI

```
> az deployment create --name "rg_deployment_1" --location southeastasia --template-file ".\resource-group.json"  --parameters "@1.parameters.json"
> az group show --name myresourcegroup
> az deployment create --name "rg_deployment_1" --location southeastasia --template-file ".\resource-group.json"  --parameters "@2.parameters.json"
> az group show --name myresourcegroup
> az group delete --name myresourcegroup -y
```
