function Build-One {

    New-Item -Path ou,ji -ItemType Directory -Force

    Get-ChildItem -File |
    ForEach-Object { if (((Select-String -InputObject $_.Name -Pattern '\d+').Matches.Value % 2) -eq 0) { Move-Item -Path $_.FullName -Destination ou } else {Move-Item -Path $_.FullName -Destination ji} }
}