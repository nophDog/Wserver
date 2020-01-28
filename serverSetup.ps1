echo '   _____      __  __  _                __  __            '
echo '  / ___/___  / /_/ /_(_)___  ____ _   / / / /___         '
echo '  \__ \/ _ \/ __/ __/ / __ \/ __ `/  / / / / __ \        '
echo ' ___/ /  __/ /_/ /_/ / / / / /_/ /  / /_/ / /_/ /  _ _ _ '
echo '/____/\___/\__/\__/_/_/ /_/\__, /   \____/ .___/  (_|_|_)'
echo '                          /____/        /_/              '



[System.Environment]::SetEnvironmentVariable('SCOOP', "$env:USERPROFILE\scoop", [System.EnvironmentVariableTarget]::User)

## scoop third-party buckets
scoop bucket add 'scoop-completion' 'https://github.com/Moeologist/scoop-completion'
scoop bucket add 'random' 'https://github.com/nophDog/random'

@('main','extras','versions','nirsoft','nerd-fonts','nonportable','jetbrains') | 
ForEach-Object { Invoke-Expression -Command "scoop bucket add $_" -WarningAction Ignore -ErrorAction Ignore }

## usefule modules
@('scoop-completion','PoshGram','PSShareGoods','PSScriptTools') | 
ForEach-Object { Install-Module -Name $_ -Scope CurrentUser -Force -ErrorAction Ignore }

## install sshd service
$file = "$env:USERPROFILE\$fileName"
Invoke-WebRequest -Uri 'https://github.com/PowerShell/Win32-OpenSSH/releases/download/v8.1.0.0p1-Beta/OpenSSH-Win64.zip' -OutFile $file
Expand-Archive -Path 