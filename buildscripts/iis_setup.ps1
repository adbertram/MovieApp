configuration iis_setup {

    Param ( [string] $nodeName = 'localhost' )

    Import-DscResource -ModuleName PSDesiredStateConfiguration
    Import-DscResource -ModuleName xPSDesiredStateConfiguration

    Node $nodeName
    {
        LocalConfigurationManager 
        { 
            RebootNodeIfNeeded = $true
        } 

        WindowsFeature Web-Server
        {
            Name = "Web-Server"
            Ensure = "Present"
        }
        WindowsFeature Web-Asp-Net45
        {
            Name = "Web-Asp-Net45"
            Ensure = "Present"
        }
        WindowsFeature NET-Framework-Features
        {
            Name = "NET-Framework-Features"
            Ensure = "Present"
        }

        WindowsFeature WebManagementConsole
        {
            Name = "Web-Mgmt-Console"
            Ensure = "Present"
        }

        xRemoteFile DotNetCore20ASPNetDownload
        {
            Uri             = "https://download.microsoft.com/download/3/a/3/3a3bda26-560d-4d8e-922e-6f6bc4553a84/DotNetCore.2.0.9-WindowsHosting.exe" 
            DestinationPath = "C:\WindowsAzure\IInstallDotNetCore20AspNet.exe" 
        }

        Package DotNetCore20Asp
        {
            Ensure = "Present"
            Path = "C:\WindowsAzure\IInstallDotNetCore20AspNet.exe"
            Arguments = "/q /norestart"
            Name = "DotNetCore20Asp"
            ProductId = "88072DD5-CE0A-3AB3-A9DF-53031BFE8BA0"
            DependsOn = "[xRemoteFile]DotNetCore20ASPNetDownload"
        }
    }
}