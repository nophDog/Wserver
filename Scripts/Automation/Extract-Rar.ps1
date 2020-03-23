## Date 👉🏻 2019-09-12 21:04:55
## Author 👉🏻 Mr.ZENG
## Description 👉🏻 RAR extraction wrapper.

function Extract-Rar{
    Param(
        [Parameter(mandatory=$true)][string]$Path,
        [string]$Destination=(Join-Path -Path (Get-Item -Path $Path).DirectoryName -ChildPath (Get-Item -Path $Path).BaseName)
    )

    If (Test-Path -Path $Path) {
        If ((Get-Item -Path $Path).Extension -eq ".rar") {
            7z.exe x $Path -o"$Destination"
        } Else {
            Write-Error "$Path is not rar archive file"
        }
    } Else {
        Write-Error "Not a valid path, try again please"
    }

}

## Last Modified 👉🏻 2019-09-17 07:29:13

