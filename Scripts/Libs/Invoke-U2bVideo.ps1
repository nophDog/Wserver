function Invoke-U2bVideo {
    param (
        [Parameter(Mandatory=$True,Position=1)]
        [string]
        $Uri,

        [ValidateScript({Test-Path -Path $_ -PathType Container})]
        [string]
        $SavePath="$env:USERPROFILE\Videos",

        [string]
        $Proxy='socks5://127.0.0.1:7891',

        [switch]
        $NoProxy
    )

    $existYoutbedl = Get-Command -Name youtube-dl -CommandType Application
    if ($existYoutbedl) {
        
        # downlaod best quality video default
        if ($NoProxy) {
            youtube-dl -f bestvideo+bestaudio -o "$SavePath\%(title)s.%(ext)s" $Uri
        } else {
            youtube-dl --proxy $Proxy -f bestvideo+bestaudio -o "$SavePath\%(title)s.%(ext)s" $Uri
        }

    } else {
        Write-Host -Object "Youtube-dl exetutable not found, install it first" -BackgroundColor Red -ForegroundColor White
    }
}
