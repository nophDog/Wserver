## use this script before making sure INIT.VIM exists in user Documents or its child folders

$nvim_init = "$env:LOCALAPPDATA\nvim\init.vim"

if (Test-Path -Path $nvim_init -PathType Leaf) {

    Write-Host -Object 'Init file already exists.' -ForegroundColor White -BackgroundColor Red -NoNewline

    ## then do a backup
    Copy-Item -Path $nvim_init -Destination $env:USERPROFILE\Documents\init.vim.bak4win -Force
    Write-Host -Object '==> Backup to DOCUMENTSM successfully' -ForegroundColor Black -BackgroundColor Green

} else {
    $backupFile = Join-Path -Path $env:USERPROFILE\Documents -ChildPath (Get-ChildItem -Path $env:USERPROFILE\Documents -Recurse -File -Name 'init.vim' | Select-Object -First 1)

    if (-not $backupFile) {
        ## backup exists --> copy and paste
        Copy-Item -Path $backupFile -Destination "$env:LOCALAPPDATA\nvim\"
    } else {
        ## backup doesn't exist --> throw an error
        Write-Host -Object "Backup doesn't exist." -ForegroundColor White -BackgroundColor Red
    }
}
