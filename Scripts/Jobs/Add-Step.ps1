$dbPath = "$env:USERPROFILE\Documents\MyLiteDB\health.db"
$stepFile = "$env:USERPROFILE\Documents\TEMP\step.txt"

if (Test-Path -Path $dbPath) {
    
    if (Test-Path -Path $stepFile) {
        Open-LiteDBConnection -Database $dbPath

        # add as litedb document
        $collection = 'step'
        [PSCustomObject]@{day = $(Get-Date).ToString()
                          step = $(Get-Content -Path $stepFile).ToString().Trim()} | 
                          ConvertTo-LiteDbBSON | 
                          Add-LiteDBDocument -Collection $collection

	    # ----------------------------------------------------------------------------------
	    #
	    # SEND NOTIFICATION TO ANDROID
	    $notifyTitle = [uri]::EscapeUriString("Today Steps Recorded")
	    $notifyDesc = (Get-Content -Path $stepFile).ToString().Trim()
	    $notifyUri = "https://joinjoaomgcd.appspot.com/_ah/api/messaging/v1/sendPush?deviceNames=OnePlus5T&text=$notifyDesc&title=$notifyTitle&apikey=d484a8d19a2f4063a9ba3229837d881f"
    
	    Invoke-WebRequest -Uri $notifyUri -Method Post | Out-Null
		# 
	    # ----------------------------------------------------------------------------------

        # disconnect
        Close-LiteDBConnection
    } else {
        Write-Host -Object 'ERROR --> Step source file not found, check first.' -ForegroundColor Red
    }
} else {
    Write-Host -Object 'ERROR --> No database provided, create one first.' -ForegroundColor Red
}
