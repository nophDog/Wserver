## Date 👉🏻 2020-01-04 19:28:29
## Author 👉🏻 Mr.ZENG
## Description 👉🏻 Fetch a landscape picture from unsplash and set as desktop background


function Set-Randash {
    
    $access = '4f0bc51f14377a50bb1949d245c1f9edf9b800e0c260b9b43ba9810fa952ced7'
    $screensaver = 'D:\AHK\ScreenSaver'

    if (-not (Test-Path -Path $screensaver -PathType Container)) {
        New-Item -Path $screensaver -ItemType Directory
    }

    $imgUri = ((Invoke-WebRequest -Uri "https://api.unsplash.com/photos/random?orientation=landscape&client_id=$access").Content | ConvertFrom-Json).urls.raw

    # download the random one
    Invoke-WebRequest -Uri $imgUri -OutFile (Join-Path -Path $screensaver -ChildPath 'unsplash_today.png')
}

Set-Randash

## Last Modified 👉🏻 2020-01-04 19:29:04