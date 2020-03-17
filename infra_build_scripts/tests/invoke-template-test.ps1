[CmdletBinding()]
param(
    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [string[]]$ResourceType,

    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [string]$ResourceGroupName
)

#requires -Module Az.Accounts,Az.Resources

## Update to 4.x
Install-Module Pester -Force

$script = @{
    Path        = "$env:System_DefaultWorkingDirectory\infra_build_scripts\tests\templates.tests.ps1"
    Parameters  = $PSBoundParameters
}

$params = @{
    Script       = $script
    OutputFormat = 'NUnitXml'
    OutputFile   = "$env:System_DefaultWorkingDirectory\infra_build_scripts\tests\templates.tests.xml"
    EnableExit   = $true
}
Invoke-Pester @params