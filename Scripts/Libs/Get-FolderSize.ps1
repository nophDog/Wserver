## Date 👉🏻 2019-09-23 16:26:13
## Author 👉🏻 Mr.ZENG
## Description 👉🏻 Retrieve a folder's storage usage
## Dependencies 👉🏻 Write-Color

function Get-FolderSize {
  [CmdletBinding()]
  Param(
    [string]$Path=(Get-Location)
  )

    if (Test-Path -Path $Path) {

        $size = (Get-ChildItem -Path $Path -Recurse | Measure-Object -Property Length -Sum).Sum
        $length = $size.ToString().Length

        Switch ($length) {

                { $length -gt 9 } { $denominator = '1GB'
 $unit = 'GB' }
                { $length -gt 6 -and $length -le 9 } { $denominator = '1MB'
 $unit = 'MB' }
                { $length -gt 3 -and $length -le 6 } { $denominator = '1KB'
 $unit = 'KB' }
                default { $denominator = 1
 $unit = 'B' }

            }

        Write-Color -Text ('{1:n2} {0}' -f $unit, ($size / $denominator)) -Color DarkRed

    } Else {
        Write-Error -Message 'Not valid path'
    }
}

## Last Modified 👉🏻 2019-09-26 09:57:18

Get-FolderSize