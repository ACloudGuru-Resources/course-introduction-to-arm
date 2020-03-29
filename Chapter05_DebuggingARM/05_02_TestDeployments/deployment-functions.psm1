function Get-DeploymentError([Microsoft.Azure.Commands.ResourceManager.Cmdlets.SdkModels.PSResourceManagerError] $error, $prefix = "") {
    $errorMessage = "$prefix$($error.Message) ($($error.Code))"
    
    if ($error.Target) {
        $errorMessage = "$errorMessage [Target: $($error.Target)]"
    }

    if ($error.Details)
    {
        $innerErrorMessages =  $error.Details | ForEach-Object { "$(Get-DeploymentError -error $_ -prefix "$prefix  ")`n" }
        return "$errorMessage`n$innerErrorMessages"
    }
    else
    {
        return $errorMessage
    }
}
