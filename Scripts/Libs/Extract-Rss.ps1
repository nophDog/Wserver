function Extract-Rss {
	param(
        [Parameter(
          Mandatory=$true,
          ValueFromPipeline=$true
        )]
	    [ValidateScript(
          {Test-Path $_ -PathType Leaf}
        )]
		$Path
	)

	(Get-Content -Path $Path -Encoding UTF8 | Select-String -Pattern '(?<=xmlUrl=")[^\s]+(?=")').Matches.Value
}
