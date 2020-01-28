$winftp = "$env:SCOOP\apps\totalcommander\current\wcx_ftp.ini"
$wincmd = "$env:SCOOP\apps\totalcommander\current\wincmd.ini"

$tcBackDir = 'E:\Archives\TCBackup'
if ((Test-Path -Path $tcBackDir -PathType Container)) {
    Remove-Item -Path $tcBackDir\* -ErrorAction Ignore
} Else {
    New-Item -Path $tcBackDir -ItemType Directory
}

Copy-Item -Path $wincmd,$winftp -Destination $tcBackDir