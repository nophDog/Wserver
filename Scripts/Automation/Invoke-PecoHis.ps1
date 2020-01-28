## Date 👉🏻 2019-10-03 22:15:33
## Author 👉🏻 Mr.ZENG
## Description 👉🏻 Execute selected history command

function Invoke-PecoHis {
	$command = Get-Content -Path (Get-PSReadlineOption).HistorySavePath | peco --prompt "Select your command :"
	if ($command.Length -eq 0) {
	} Else {
		Invoke-Expression -Command $command
	}
}