$hfkey = 'bfdf26de755b4f859f41a72ad4e28b27'
$workplace = "$env:USERPROFILE\Documents\TEMP\workplace.txt"
$dbPath = "$env:USERPROFILE\Documents\MyLiteDB\diary.db"
$timestamp = (Get-Date).ToString()
#
# ---------------------------------------------------------------------
# for selected text use
# $count = (Measure-Object -InputObject $args[0] -Character).Characters
# ---------------------------------------------------------------------
#
# get info array from returned JSON (using heWeather free api)
$todayWeatherInfo = ((Invoke-WebRequest -Uri "https://free-api.heweather.net/s6/weather/forecast?location=yuhu&key=$hfkey").Content | ConvertFrom-Json).HeWeather6.daily_forecast

# min & max temperature
$tempMin = $todayWeatherInfo[0].tmp_min
$tempMax = $todayWeatherInfo[0].tmp_max

$tempDayKeyword = $todayWeatherInfo[0].cond_txt_d
$humidity = $todayWeatherInfo[0].hum


$i = 1

while (Test-Path -Path $workplace) {
	
	$lastWrDay = (Get-Item -Path $workplace).LastWriteTime.Day

	if ($lastWrDay -eq (Get-Date).Day) {
		
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
	    $notifyDesc = (Get-Content -Path $workplace -Raw).ToString().Substring(0,10) # require diary to be at least 50 chars
	    $notifyDescEncode = [uri]::EscapeUriString("$notifyDesc......")
	    $notifyUri = "https://joinjoaomgcd.appspot.com/_ah/api/messaging/v1/sendPush?deviceNames=OnePlus5T&text=$notifyDescEncode&title=$notifyTitle&apikey=d484a8d19a2f4063a9ba3229837d881f"
    
	    Invoke-WebRequest -Uri $notifyUri -Method Post | Out-Null

        exit

	} else {

		# extra five hours to wait for new diary
		if ($i -lt 6) {
			Start-Sleep -Seconds 18000
			$i++
		} else {
			exit
		}
	}
}


# Sending warning message to Android
#
$warningText = [uri]::EscapeUriString('WARNING --> No diary file found')
$warningTitle = [uri]::EscapeUriString('record failed')
$warningUri = "https://joinjoaomgcd.appspot.com/_ah/api/messaging/v1/sendPush?deviceNames=OnePlus5T&text=$warningText&title=$warningTitle&apikey=d484a8d19a2f4063a9ba3229837d881f"

Invoke-WebRequest -Uri $warningUri -Method Post
