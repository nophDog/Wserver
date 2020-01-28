$stateFile = "$env:USERPROFILE\Documents\player.xml"
$playListFile = "$env:USERPROFILE\Documents\playlist.xml"


If ($args.Length -eq 0) { $args = 'next' } # default action for no-argument input

If (Test-Path -Path $stateFile) {
	Import-Clixml -Path $stateFile | Set-Variable -Name $player
    
	If ($player.DownloadProgress -eq 1) {
		if ($args -eq 'pause') { $player.Pause(); exit } Else { $player.Close() }
	} Else {
	}
} Else {
	New-Item -Path $stateFile -ItemType File
}


Switch ($args) {
	'random' {
		$randomSeed = Get-Random -Maximum $playListFile.Count -Minimum 0
		$currentSong = $playListFile[$randomSeed]
	}
	'next' {
		$prevCode = $playListFile.Keys | Where-Object { $playListFile[$_] -eq $player.Source.OriginalString }
		$currentSong = $playListFile[$prevCode + 1]
	}
	'prev' {
			
	}
	'pause' {
		if () {
			
		}
	}
	'quit' {}
}
		
$player.Open($currentSong)
$player.Play()
Send-OSNotification -Body "$currentSong" -Title "正在播放"
$player | Export-Clixml -Path $stateFile
$lastSong = $player.Source.OriginalString | Export-Clixml -Path $env:USERPROFILE\Documents\lastsong.xml}
		
	


$player = New-Object -TypeName System.Windows.Media.MediaPlayer
$player.Open($playList[$randomItem])
$player.Play()
$player | Export-Clixml -Path $stateFile

$timeSpan = '{0:n1}' -f ($player.NaturalDuration.TimeSpan.TotalSeconds)
$timeSpan