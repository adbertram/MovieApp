[CmdletBinding()]
param(
    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [hashtable]$Parameter
)

#requires -Module Az.Accounts,Az.Resources

## Update to 4.x
Install-Module Pester -Force

$script = @{
    Path        = "$env:System_DefaultWorkingDirectory\buildscripts\tests\infrastructure.tests.ps1"
    Parameters  = $Parameter
}

$params = @{
    Script       = $script
    OutputFormat = 'NUnitXml'
    OutputFile   = "$env:System_DefaultWorkingDirectory\buildscripts\tests\infrastructure.tests.xml"
    EnableExit   = $true
}
Invoke-Pester @params