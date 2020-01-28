## Date 👉🏻 2019-10-11 09:50:52
## Author 👉🏻 Mr.ZENG
## Description 👉🏻 Job to backup system Documents folder

# temporary container
$tmpCont = 'E:\TMP'

if (-not (Test-Path -Path $tmpCont -PathType Container)) {
    New-Item -Path $tmpCont -ItemType Directory
} Else {
    Remove-Item -Path $tmpCont\* -Recurse -Force
}

Get-ChildItem -Path C:\Users\Reno\Documents | Where-Object { $_.FullName -notmatch 'sspai'} | Copy-Item -Destination $tmpCont -ErrorAction Ignore -Recurse

Get-ChildItem -Path $tmpCont | Compress-Archive -DestinationPath ("E:\Archives\docs_backup_{0}.zip" -f (Get-Date -Format 'dd-MM-yyyy'))

Remove-Item -Path $tmpCont -Recurse -Force

## Last Modified 👉🏻 2019-10-11 09:51:15