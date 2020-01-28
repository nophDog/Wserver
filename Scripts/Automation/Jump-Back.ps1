function Record-Location{
    Set-Variable -Name LASTLOCATION -Value $(Get-Location) -Scope global
    Set-Location -Path $args[0]
}

function Jump-Back{
    $anchor = $(Get-Location)
    Set-Location -Path $LASTLOCATION
    Set-Variable -Name LASTLOCATION -Value $anchor -Scope global
}