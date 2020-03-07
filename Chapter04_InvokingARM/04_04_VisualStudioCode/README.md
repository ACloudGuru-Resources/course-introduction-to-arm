# Invoking Azure Resource Manager: Visual Studio Code

We will deploy a static website that makes an AJAX call to a config file in a storage account as per the final lab of the previous chapter. We will take our Azure PowerShell Cmdlets script from the last lab and create an environment within Visual Studio Code that productively supports development.

## Using correct PowerShell version

If you have multiple versions of PowerShell installed on your system, ensure that you are using the one that has the `Az` Azure PowerShell Cmdlets installed. You can [change the version of PowerShell being used in the VS Code PowerShell extension](https://docs.microsoft.com/en-us/powershell/scripting/components/vscode/using-vscode?view=powershell-7#choosing-a-version-of-powershell-to-use-with-the-extension).

## Running the lab

Investigate the files in the `.vscode` directory. [Launch documentation](https://code.visualstudio.com/docs/editor/debugging#_launch-configurations). [Extension file documentation](https://code.visualstudio.com/docs/editor/extension-gallery#_workspace-recommended-extensions) [PowerShell extension documentation](https://marketplace.visualstudio.com/items?itemName=ms-vscode.PowerShell). [ARM extension documentation](https://marketplace.visualstudio.com/items?itemName=msazurermtools.azurerm-vscode-tools).

You should be able to hit F5 if you open this folder in VS Code. It will support breakpoint debugging of the PowerShell code and will pass in the parameters specified in `Deploy-Local.ps1` to the `Deploy.ps1` file, even if you are currently editing the `Deploy.ps1` file. This makes for a great local editing / development experience. You should also have great syntax highlighting, intellisense and autocomplete in the ARM template.
