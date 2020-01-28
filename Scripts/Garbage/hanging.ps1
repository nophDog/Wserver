if (Test-Path -Path $workplace) {
	$count = Measure-Object -InputObject $(Get-Content -Path $workplace -Raw) -Character
	$year = (Get-Date).Year

    # Connect to database
    Open-LiteDBConnection -Database $dbPath

    [PSCustomObject]@{
        date = $timestamp
        weather = "{0} {1}-{2}℃" -f $tempDayKeyword,$tempMin,$tempMax
        humidity = $humidity
        content = (Get-Content -Path $workplace -Raw).ToString()
        count = $count.Characters
    } | ConvertTo-LiteDbBSON |
	Add-LiteDBDocument -Collection $year
    
    # disconnect from the database
    Close-LiteDBConnection

	# ----------------------------------------------------------------------------------
	#
	# send notification to Android
	$notifyTitle = [uri]::EscapeUriString("$(Get-Date -Format d) Diary Added")
	$notifyDesc = (Get-Content -Path $workplace -Raw).ToString().Substring(0,50) # require diary to be at least 50 chars
	$notifyDescEncode = [uri]::EscapeUriString("$notifyDesc......")
	$notifyUri = "https://joinjoaomgcd.appspot.com/_ah/api/messaging/v1/sendPush?deviceNames=OnePlus5T&text=$notifyDescEncode&title=$notifyTitle&apikey=d484a8d19a2f4063a9ba3229837d881f"

	Invoke-WebRequest -Uri $notifyUri -Method Post | Out-Null

} else {
	Write-Host -Object "ERROR --> No workplace file found, create one first." -ForegroundColor Red
}
