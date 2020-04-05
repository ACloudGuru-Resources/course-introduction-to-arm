function New-AzResourceGroupDeploymentWithErrorHandling($Name, $ResourceGroupName, $TemplateFile, $TemplateParameterObject) {
    $deploymentName = ("$Name-" + (Get-Date -Format "yyyy-MM-ddTHH.mm.ss"))
    $result = New-AzResourceGroupDeployment -Name $deploymentName -ResourceGroupName $ResourceGroupName -TemplateFile $TemplateFile -TemplateParameterObject $TemplateParameterObject -ErrorAction Continue -Verbose
    Write-Host (ConvertTo-Json $result) -ForegroundColor Gray

    if ((-not $result) -or ($result.ProvisioningState -ne "Succeeded")) {
        Write-Error "Deployment failed; retrieving operation details..." -ErrorAction Continue
        $operations = Get-AzResourceGroupDeploymentOperation -DeploymentName $deploymentName -ResourceGroupName $ResourceGroupName
        $operations | ForEach-Object {
            Write-Host "Operation $($_.id):" -ForegroundColor Magenta
            Write-Host "Properties:" -ForegroundColor Cyan
            Write-Host ($_.Properties | Select-Object -Property * -ExcludeProperty Request,Response | ConvertTo-Json -Depth 10).ToString() -ForegroundColor Gray
        }
        return $false
    }
    return $true
}
