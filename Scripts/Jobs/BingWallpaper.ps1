$bingWp = 'https://bing.biturl.top/?resolution=1366&format=json&index=0&mkt=zh-CN'
$savePath = "$env:USERPROFILE\Pictures\Wallpaper\Bing"

$todayUri = ((Invoke-WebRequest -Uri $bingWp).Content | ConvertFrom-Json).url


if (Test-Path -Path $savePath) {
} else {
	Write-Host -Object "NEW --> Save folder not found, creating..." -ForegroundColor Green
	New-Item -Path $savePath -ItemType Directory -Force
}

Invoke-WebRequest -Uri $todayUri -OutFile "$savePath\$(Get-Date -Format "dd-MM-yyyy")-bing(1366x768).jpg"
