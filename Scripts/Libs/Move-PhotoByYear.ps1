function Move-PhotoByYear {
	Param(
		[int]$Year,
        [string]$SourcePath=@(),
        [string]$TargetPath
	)

    $lastYear = $Year - 1
    $nextYear = $Year + 1

    foreach ($path in $SourcePath) {
        Get-ChildItem -Path $path -Recurse -File -Include "*.jpg","*.jpeg","*.png","*.webp" | ? { $_.LastWriteTime -gt [datetime]"12/31/$lastYear" -and $_.LastWriteTime -lt [datetime]"1/1/$nextYear" } | Move-Item -Destination $TargetPath
    }
}