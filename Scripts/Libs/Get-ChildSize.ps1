## Date 👉🏻 2019-09-23 11:15:03
## Author 👉🏻 Mr.ZENG
## Description 👉🏻 Get directories' sizes

function Get-ChildSize {

  param (
  #  [Parameter(Mandatory=$true)][String]$Path
      [String]$Path=(Get-Location).Path,
      [Switch]$Hidden
  )
function script:folderSize {

        foreach ($PathItem in $input) {

            $Path = $PathItem.FullName

            # Check if folder empty or if item is file
            if ((Test-Path -Path $PathItem -PathType Leaf) -or ((Get-ChildItem -Path $Path -Recurse -File).Length -eq 0)) {
                continue   # jump to next
            }

            $size = (Get-ChildItem -Path $Path -Recurse | Measure-Object -Property Length -Sum).Sum
            $lengths = $size.ToString().Length

            Switch ($lengths) {
                #{ $lengths -gt 12 } { $unit = "TB" }
                { $lengths -gt 9 } { $denominator = '1GB'
 $unit = 'GB' }
                { $lengths -gt 6 -and $lengths -le 9 } { $denominator = '1MB'
 $unit = 'MB' }
                { $lengths -gt 3 -and $lengths -le 6 } { $denominator = '1KB'
 $unit = 'KB' }
                default { $denominator = 1
 $unit = 'B' }
            }

            # Create objects for better formatting
            $roundedSize = [math]::Round($size / $denominator, 2)
            $targetObj = New-Object -TypeName PSObject
            $targetObj | Add-Member -MemberType NoteProperty -Name Path -Value (Get-Item -Path $Path).FullName
            Add-Member -InputObject $targetObj -MemberType NoteProperty -Name Size -Value ('{0} {1}' -f $roundedSize, $unit)
            Add-Member -InputObject $targetObj -MemberType NoteProperty -Name Length -Value $size

            $targetObj
            }
    }

    if ($Hidden) {
        Get-ChildItem -Path $Path -Directory | folderSize | Sort-Object -Property Length -Descending | Format-Table -Property Path,@{n='Size';e={$_.Size};align='right'} -AutoSize
    } Else {
        Get-ChildItem -Path $Path -Directory | Where-Object { $_.BaseName -notlike ".*" } | folderSize | Sort-Object -Property Length -Descending | Format-Table -Property Path,@{n='Size';e={$_.Size};align='right'} -AutoSize
    }
}

Get-ChildSize

## Last Modified 👉🏻 2019-11-15 08:39:15
