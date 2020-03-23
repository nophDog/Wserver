# https://github.com/mikefrobbins/PowerShell/blob/master/MrToolkit/Public/Test-MrURL.ps1

function Test-URL {
    [CmdletBinding()]
    param (
        [string]$Uri,
        [switch]$Detailed
    )

    $CurrentErrorAction = $ErrorActionPreference

    $ErrorActionPreference = 'SilentlyContinue'
    $Result = Invoke-WebRequest -Uri $Uri -TimeoutSec 30
    $ErrorActionPreference = $CurrentErrorAction

    if ($Result.StatusCode -ne 200) {
        $false
    }
    elseif (-not $Detailed) {
        $true
    }
    else {
        [pscustomobject]@{
            StatusDescription = $Result.StatusDescription
            StatusCode = $Result.StatusCode
            ResponseUri = $Result.BaseResponse.ResponseUri
            Server = $Result.BaseResponse.Server
        }
    }

}