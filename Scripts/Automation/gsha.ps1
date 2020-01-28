function gsha {
    param(
        [Parameter(Mandatory=$true)]
        $Path
    )

    (Get-FileHash -Path $Path -Algorithm SHA256).Hash | Set-Clipboard
}