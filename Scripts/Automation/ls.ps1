## colorised ls

function ls {
	param (
		[String]
		$Path=".",

		[Switch]
		[Alias('h')]
		$Hidden
	)

	$file = 0
	$dir = 0

	if ($Hidden) {

				(Get-ChildItem -Path $Path -Hidden).Name | Sort-Object |
					ForEach-Object { if (Test-Path -Path $_ -PathType Container) {
							Write-Host -Object $_ -ForegroundColor Magenta
							$dir += 1
						} else {
								Write-Host -Object $_ -ForegroundColor DarkGray
								$file += 1
						}}
			} else {

					(Get-ChildItem -Path $Path).Name | Sort-Object |
					ForEach-Object { if (Test-Path -Path $_ -PathType Container) {
							Write-Host -Object $_ -ForegroundColor DarkYellow
							$dir += 1
						} else {

							##--> Blue : VIDEO
							##--> DarkGreen : PICTURES
							##--> Green : EXECUTABLE
							##--> DarkRed : COMPRESSED
							##--> Cyan : POWERSHELL SCRIPTS
							if ($_ -match '\.(mp4|mkv)$') {
									Write-Host -Object $_ -ForegroundColor Blue
								} elseif ($_ -match '\.(exe|msi)$') {
										Write-Host -Object $_ -ForegroundColor Green
									} elseif ($_ -match '\.(zip|tar|gzip|rar)$') {
											Write-Host -Object $_ -ForegroundColor DarkRed
										} elseif ($_ -match '\.(jpg|png|jpeg|gif)$') {
												Write-Host -Object $_ -ForegroundColor DarkGreen
											} elseif ($_ -match '\.(ps1)$') {
													Write-Host -Object $_ -ForegroundColor Cyan
												} else {
														Write-Host -Object $_ -ForegroundColor Gray
													}

								$file += 1
							}}
				}



	$file_emoji = [char]::ConvertFromUtf32(0x1f4dd)
	$dir_emoji = [char]::ConvertFromUtf32(0x1f4c2)

	Write-Host -Object "`n" -NoNewline
	Write-Host -Object "$file_emoji Files: " -NoNewline
	Write-Host -Object "$file" -ForegroundColor Yellow
	Write-Host -Object "$dir_emoji Directories: " -NoNewline
	Write-Host -Object "$dir" -ForegroundColor Yellow

}
