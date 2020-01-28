function Get-Empty {
    param(
        [Parameter()]
        $Path=$(Get-Location).Path,

        [switch]
        $Recurse = $false
    )
    
    (Get-ChildItem $Path -Recurse:$Recurse |
    Where { $_.PsIsContainer -eq $true } |
    Where { $_.GetFiles().Count -eq 0 -and $_.GetDirectories().Count -eq 0 }).FullName
    
}