# https://jdhitsolutions.com/blog/powershell/7222/learn-more-about-powershell-and-regular-expressions/
#
Function GitStat {
    param()

	## persist current directory
	$pre = (Get-Location).Path

	## LOOKING FOR .GIT FOLDER
	# $i = 4  # searching up to 4 parent folder
	# While ($i -gt 0) {
		# $i -= 1
	
		# if (Test-Path -Path '.git') {
				# break
			# } else {

				# if ($i -eq 0) {
					# Write-Host -Object 'It''s probably not a git repo' -ForegroundColor Red; break
					# exit

				# } else {
					# try {Set-Location -Path (Get-Item -Path .).Parent.FullName} catch {
						# Write-Host -Object 'Not a valid git repo' -ForegroundColor Red; break
						# exit
						# }
				# }
			# }
	# }
	
	$root = git rev-parse --show-toplevel
	if ($root.Contains('fatal: not a git repository')) {
			Write-Host -Object 'Not a git repository' -ForegroundColor White -BackgroundColor Red
			return
		} 

    # $s = (git status --porcelain).trim()
	try {$status = (git status --porcelain).trim()} catch {$status = git status --porcelain}
    $untracked = ($status). Where({$_ -match "^\?\?"})
    $add = ($status).where({$_ -match "^A"})
    $del = ($status).where({$_ -match "^D"})
    $mod = ($status).where({$_ -match "^M"})
    [regex]$rx = "\*.\S+"
    #get the matching git branch which has the * and split the string to get only the branch name
    $branch = $rx.match((git branch)).value.split()[-1]
    Write-Host "[" -NoNewline -ForegroundColor Red
    Write-Host "$branch : " -NoNewline -ForegroundColor Yellow
    Write-Host "+$($add.count)" -NoNewline -ForegroundColor Green
    Write-Host " ~$($mod.count)" -NoNewline -ForegroundColor Cyan
    Write-Host " -$($del.count)" -NoNewline -ForegroundColor Red
    Write-Host " ?$($untracked.count)" -NoNewline -ForegroundColor Magenta
    Write-Host "] " -NoNewline -ForegroundColor Red

	Set-Location -Path $pre

}
