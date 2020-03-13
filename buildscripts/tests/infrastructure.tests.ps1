[CmdletBinding()]
param(
    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [string]$PublicDnsName
)

describe "Network connectivity" {
    it "$PublicDnsName is connectable on TCP port 80" {
        (Test-NetConnection -ComputerName $PublicDnsName -CommonTcpPort HTTP).TcpTestSucceeded | should -Be $true
    }
}