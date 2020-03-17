param (
    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [string]$ArmOutputString,

    [Parameter()]
    [ValidateNotNullOrEmpty()]
    [switch]$MakeOutput
)

Write-Output "Retrieved input: $ArmOutputString"
$armOutputObj = $ArmOutputString | convertfrom-json

$armOutputObj.PSObject.Properties | ForEach-Object {
    $type = ($_.value.type).ToLower()
    $keyname = "Output_"+$_.name
    $value = $_.value.value

    $varPrefix = "##vso[task.setvariable variable=$keyname"

    $vsoAttribs = @("task.setvariable variable = $_")
    if ($type -eq "securestring") {
        $vsoAttribs += 'isSecret = true'
    } elseif ($type -ne "string") {
        throw "Type '$type' is not supported for '$keyname'"
    }

    if ($MakeOutput.IsPresent) {
        $vsoAttribs += 'isOutput = true'
    }

    $attribString = $vsoAttribs -join ';'
    $var = "##vso[$attribString]$($value)"
    Write-Output -InputObject $var
}