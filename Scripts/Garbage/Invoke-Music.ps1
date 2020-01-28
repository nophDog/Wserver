## Date 👉🏻 2019-09-25 17:10:11
## Author 👉🏻 Mr.ZENG
## Description 👉🏻

function Invoke-Music {
    $playlist = Import-Clixml -Path "$env:USERPROFILE\Documents\playlist.xml"
    $randomSeed = Get-Random -Minimum 0 -Maximum $playlist.Count

    $player = New-Object -TypeName System.Windows.Media.MediaPlayer
    $player.Open($playlist[$randomSeed])
    $player.Play()

}