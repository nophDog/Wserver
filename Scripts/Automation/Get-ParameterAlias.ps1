# https://github.com/mikefrobbins/PowerShell/blob/master/MrToolkit/Public/Get-MrParameterAlias.ps1
function Get-ParameterAlias {

    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [string]$Name
    )

    (Get-Command -Name $Name).Parameters.Values |
    Where-Object Aliases |
    Select-Object -Property Name, Aliases

}