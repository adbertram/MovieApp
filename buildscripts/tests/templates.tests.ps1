[CmdletBinding()]
param(
    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [string[]]$ResourceType,

    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [string]$ResourceGroupName
)

foreach ($type in $ResourceType) {

    ## Find the ARM template for that particular reasource type and it's parmaeter file
    $templateFilePath = "$env:System_DefaultWorkingDirectory\buildscripts\arm_templates\$type.json"
    $parameterFilePath = "$env:System_DefaultWorkingDirectory\buildscripts\arm_templates\$type.params.json"

    describe "JSON validation for $type resource" {

        it 'template JSON is correct' {
            { Get-Content -Path $templateFilePath -Raw | ConvertFrom-Json -ErrorAction Stop } | should not throw
        }
    }

    describe "Compute template validation for $type resource" {
        it 'template passes validation check' {
            $parameters = @{
                TemplateFile            = $templateFilePath
                TemplateParameterFile   = $parameterFilePath
                ResourceGroupName       = $ResourceGroupName
            }
            (Test-AzResourceGroupDeployment @parameters).Details.Message | should -Benullorempty
        }
    }
}