function Get-Video {

    Param (
        [string]$UrlPath,
        [string]$Destination=(Get-Location)
    )

    # check if DESTINATION path exists
    If (Test-Path -Path $Destination) {
    } Else {
        New-Item -Path $Destination -ItemType Directory
    }

    $reader = [System.IO.File]::OpenText((Get-Item -Path $UrlPath).FullName)


    # read file line by line
    for () {
        $line = $reader.ReadLine()
        if ($line -eq $null) { break }

        # process the line
        annie.exe -x http://127.0.0.1:7890 -o $Destination $line
    }

    $reader.Close()

}