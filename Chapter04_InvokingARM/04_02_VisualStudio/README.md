# Invoking Azure Resource Manager: Visual Studio

We will deploy a website to Azure Web Apps where the definition of the website code and the website infrastructure and both defined in and deployed from Visual Studio.

1. Open Visual Studio 2019
2. New Project -> Azure Resource Group -> Web app -> `MyACGWebApp`
3. Review what has been created
4. Deploy
4. Add -> New Project -> ASP.NET Core Web Application -> Web Application -> `MyWebApp`
5. Add reference to web application from resource group project
6. Add new resource to `WebSite.json` -> Web deploy -> `Webdeploy`
7. Review what has been added to `WebSite.json`
8. Add the following values to `WebSite.parameters.json`:
    ```json
    "WebdeployPackageFolder": {
      "value": "MyWebApp"
    },
    "WebdeployPackageFileName": {
      "value": "package.zip"
    }
    ```
9. Deploy resource group project (notice how it now asks for a storage account and passes the `-UploadArtifact flag`)
10. View the website
11. Look at what was uploaded to the storage account during deployment
12. Clean up the deployed resources:
    ```
    > az group delete --name MyACGWebApp -y
    > az group delete --name ARM_Deploy_Staging -y
    ```
