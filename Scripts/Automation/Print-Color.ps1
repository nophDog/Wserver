function Print-Color {
    [System.Enum]::GetValues([System.ConsoleColor]) |
    % { Write-Host -Object $_ -ForegroundColor $_ }
}