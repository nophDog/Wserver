# require bat.exe
# read powershell scripts with syntax highlighting

function ghc {
	param (
		[Parameter(Mandatory=$true)]
		$Path
	)

	Get-Content -Path $Path.Trim() | bat -l ps1

}
