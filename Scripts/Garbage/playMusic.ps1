Import-Clixml -Path C:\Users\Reno\Documents\playlist.xml | Set-Variable -Name playList

function playm {
	$randomSeed = Get-Random -Minimum 0 -Maximum $playList
	$player = New-Object -TypeName System.Windows.Media.MediaPlayer
	$player.Open($playList[$randomSeed])
	$player.Play()
}

playm # 开始播放音乐

while ($player.Position -gt $player.NaturalDuration) # 当播放结束时
{
	playm
}
