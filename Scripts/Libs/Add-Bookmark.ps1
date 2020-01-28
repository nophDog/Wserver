# parse input argument
$raw_bookmark = [string]$args[0]
$timestamp = (Get-Date).ToString()
$title = $raw_bookmark.Split('^')[0].TrimEnd()
$url = $raw_bookmark.Split('^')[1].TrimStart()


$bookmark = [PSCustomObject]@{
    title = $title
    url = $url
    timestamp = $timestamp
}

# initial bookmark database
$dbPath = "$Env:USERPROFILE\Documents\MyLiteDB\webinfo.db"

if (Test-Path -Path $dbPath) {
    # connect to database
    Open-LiteDBConnection -Database $dbPath

    $bookmark | ConvertTo-LiteDbBSON | 
	Add-LiteDBDocument -Collection (Get-LiteDBCollectionName).Collection

} Else {
    Write-Host -Object "ERROR --> No database found, create one first." -ForegroundColor Red
}

# disconnect from database
Close-LiteDBConnection
