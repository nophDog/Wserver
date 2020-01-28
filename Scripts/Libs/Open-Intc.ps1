## Date Created 👉🏻 2019-09-12 20:57:51
## Author 👉🏻 Mr.ZENG
## Description 👉🏻 Open file or folder in Total Commander

function Open-Intc {
    Param(
        [Parameter(ValueFromPipeline=$true)][string]$Path,
        [switch]$Left
    )

    If (Test-Path -Path $Path) {
        If ($Left) {
            totalcmd64.exe /O /A /L="$Path"
        } Else {
            totalcmd64.exe /O /A /R="$Path"
        }
    } Else {
        Write-Error "Not valid path, try again"
    }
}


## Last Modified 👉🏻 2019-09-14 06:56:43 