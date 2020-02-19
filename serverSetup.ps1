echo '   _____      __  __  _                __  __            '
echo '  / ___/___  / /_/ /_(_)___  ____ _   / / / /___         '
echo '  \__ \/ _ \/ __/ __/ / __ \/ __ `/  / / / / __ \        '
echo ' ___/ /  __/ /_/ /_/ / / / / /_/ /  / /_/ / /_/ /  _ _ _ '
echo '/____/\___/\__/\__/_/_/ /_/\__, /   \____/ .___/  (_|_|_)'
echo '                          /____/        /_/              '



[System.Environment]::SetEnvironmentVariable('SCOOP', "$env:USERPROFILE\scoop", [System.EnvironmentVariableTarget]::User)
Invoke-Expression (New-Object System.Net.WebClient).DownloadString('https://get.scoop.sh')

## scoop third-party buckets
scoop bucket add 'scoop-completion' 'https://github.com/Moeologist/scoop-completion'
scoop bucket add 'random' 'https://github.com/nophDog/random'

@('main','extras','versions','nirsoft','nerd-fonts','nonportable','jetbrains') |
ForEach-Object { Invoke-Expression -Command "scoop bucket add $_" -WarningAction Ignore -ErrorAction Ignore }

## usefule modules
@('scoop-completion','PoshGram','PSShareGoods','PSScriptTools') |
ForEach-Object { Install-Module -Name $_ -Scope CurrentUser -Force -ErrorAction Ignore }
