function Get-FolderSize {
	Param(
		[parameter(ValueFromPipeline)][string]$Path
	)
    # Check if folder empty
    if ((Get-ChildItem -Path $Path -Recurse -File).Length -eq 0) {
        break
    }

    $size = (Get-ChildItem -Path $Path -Recurse | Measure-Object -Property Length -Sum).Sum
    $lengths = $size.ToString().Length

    Switch ($lengths) {
        { $lengths -gt 12 } { $unit = "TB" }
        { $lengths -gt 9 -and $lengths -le 12 } { $unit = "GB" }
        { $lengths -gt 6 -and $lengths -le 9 } { $unit = "MB" }
        { $lengths -gt 3 -and $lengths -le 6 } { $unit = "KB" }
        default { $unit = "B" }
    }

    $roundedSize = [math]::Round($size / "1$unit", 2)
    $targetObj = New-Object -TypeName PSObject
    $targetObj | Add-Member -MemberType NoteProperty -Name Path -Value (Get-Item -Path $Path).FullName
    Add-Member -InputObject $targetObj -MemberType NoteProperty -Name Size -Value "$roundedSize $unit"
    # "{0:n2} $unit  -=>  $Path" -f ($size / "1$unit")

    $targetObj
}