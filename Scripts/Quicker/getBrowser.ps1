# msedge
if (Get-Process -Name msedge -ErrorAction SilentlyContinue) {
    (Get-Process -Name msedge)[0].Path
} else {

    # vivaldi
    if ((Get-Process -Name vivaldi -ErrorAction SilentlyContinue) -and (-not (Get-Process -Name vivaldi)[0].MainWindowTitle -eq '')) {
        (Get-Process -Name vivaldi)[0].Path
    } else {

        # firefox
        if (Get-Process -Name firefox -ErrorAction SilentlyContinue) {
        (Get-Process -Name firefox)[0].Path
        } else {

            # default
            Write-Host 'C:\Program Files (x86)\Microsoft\Edge Beta\Application\msedge.exe' -NoNewline
        }
    }
}