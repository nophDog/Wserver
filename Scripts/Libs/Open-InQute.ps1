function Open-InQute {
	param (
		[Parameter(Mandatory=$true)]
		[string]
		$Uri
	)

	qutebrowser.exe $Uri.Trim().ToString()
}
