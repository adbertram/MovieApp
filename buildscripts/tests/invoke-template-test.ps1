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
    Path        = "$env:System_DefaultWorkingDirectory\buildscripts\tests\templates.tests.ps1"
    Parameters  = $PSBoundParameters
}

$params = @{
    Script       = $script
    OutputFormat = 'NUnitXml'
    OutputFile   = "$env:System_DefaultWorkingDirectory\buildscripts\tests\templates.tests.xml"
    EnableExit   = $true
}
Invoke-Pester @params