$url = ((Invoke-WebRequest -Uri 'https://bing.biturl.top').Content | ConvertFrom-Json).url

Get-ChildItem -Path "D:\AHK\ScreenSaver" | Remove-Item -Force
Invoke-WebRequest -Uri $url -OutFile "D:\AHK\ScreenSaver\bing_today.jpg"