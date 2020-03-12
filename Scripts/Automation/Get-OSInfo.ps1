function Get-OSInfo {
    $osInfo = Get-ComputerInfo

    [PSCustomObject]@{
        OSName = $osInfo.OsName
        OSArchitecture = $osInfo.CsSystemType
        "System Family" = $osInfo.CsSystemFamily
        OSVersion = $osInfo.OsVersion
        OSBuildNumber = $osInfo.OsBuildNumber
        "HOST\User" = $osInfo.CsUserName
        OSLocale = $osInfo.OsLocale
        "Hyper-V" = $osInfo.HyperVisorPresent
        "Total RAM" = "{0:N2}" -f  ($osInfo.CsTotalPhysicalMemory / 1GB) + " GB"
        "Free RAM" =  "{0:N2}" -f  ($osInfo.OsFreePhysicalMemory / 1MB) + " GB"
        UpTime = (Get-Uptime).Hour + "Hours"
        "PS Edition" = $PSVersionTable.PSEdition
        "PS Version" = $PSVersionTable.PSVersion
        "Process Count" = $osInfo.OsNumberOfProcesses
        "Service Count" = (Get-Service | Where-Object {$_.Status -eq 'Running'}).Count

    }

}