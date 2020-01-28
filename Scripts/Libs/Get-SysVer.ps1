function Get-SysVer {
    Write-Host (Get-CimInstance -Class Win32_OperatingSystem).Version
} # End Get-SysVer

Get-SysVer