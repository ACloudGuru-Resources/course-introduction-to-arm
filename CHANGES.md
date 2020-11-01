# Version 1.1

Released *TBD* 2020.

There are two changes being addressed in the course:

1. The `az group deployment *` command is [being deprecated](https://github.com/Azure/azure-cli/issues/12860) eventually in favour of `az deployment group *`.
2. The ability to connect to storage accounts without specifying an access method and relying on the SDK (CLI or PowerShell) to automatically use the access keys is [being deprecated](https://github.com/Azure/azure-cli/pull/12524) in favour of being explicit.

This affects the following lessons:

* `03_03_ExecutingBasicTemplate` - Switch `az group deployment create` with `az deployment group create`
* `03_05_ModifyingTheBasicTemplate` - Switch `az group deployment create` with `az deployment group create`
* `03_07_AzurePortalAutomationScripts` - Switch `az group deployment create` with `az deployment group create`, remove slide note about `--auth-mode key` and update code to `--auth-mode login` and include new instruction about setting up your account with `Storage Blob Data Contributor` permission for your subscription
* `03_08_AzureResourceManager` - Switch `az group deployment create` with `az deployment group create`, remove slide note about `--auth-mode key` and update code to `--auth-mode login`
* `03_09_ARMTemplateReferenceDocumentation` - Switch `az group deployment create` with `az deployment group create`, remove slide note about `--auth-mode key` and update code to `--auth-mode login`
* `04_01_AzureCloudShell` - Switch `az group deployment create` with `az deployment group create`, update `--auth-mode key` to `--auth-mode login`
* `04_03_AzurePowerShell` - Switch `az group deployment create` with `az deployment group create`, update using the access key with `-ConnectedAccount`
* `05_02_TestDeployments` - Switch `az group deployment validate` with `az deployment group validate`, update using the access key with `-ConnectedAccount`
* `05_03_DebugLogging` - Switch `az group deployment create` with `az deployment group create`
* `05_04_UsingDeploymentErrors` - Switch `az group deployment create` with `az deployment group create`
* `05_05_DeploymentHistory` - Switch `az group deployment create` with `az deployment group create`

# Vesion 1.0

Released August 2020.