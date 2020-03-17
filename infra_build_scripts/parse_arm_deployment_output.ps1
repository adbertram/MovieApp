[CmdletBinding()]
param (
    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [string]$ArmOutputString,

    [Parameter()]
    [ValidateNotNullOrEmpty()]
    [switch]$MakeOutput
)

try {
    Write-Output "Retrieved input: $ArmOutputString"
    $armOutputObj = $ArmOutputString | convertfrom-json

    $armOutputObj | gm | Out-String

    $armOutputObj.PSObject.Properties | ForEach-Object {
        $type = ($_.value.type).ToLower()
        $keyname = $_.Name
        $value = $armOutputObj.Value

        $vsoAttribs = @("task.setvariable variable = $keyName")
        
        if ($type -eq "securestring") {
            $vsoAttribs += 'isSecret=true'
        } elseif ($type -ne "string") {
            throw "Type '$type' is not supported for '$keyname'"
        }

        if ($MakeOutput.IsPresent) {
            $vsoAttribs += 'isOutput=true'
        }

        $attribString = $vsoAttribs -join ';'
        $var = "##vso[$attribString]$value"
        Write-Output -InputObject $var
    }
} catch {
    Write-Error -Message $_.Exception.Message
}