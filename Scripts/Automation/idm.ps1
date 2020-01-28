function idm {
	Param(
		[Parameter(Mandatory=$true)]
        $Uri
	)

    & "C:\Program Files (x86)\Internet Download Manager\IDMan.exe" /n /d "$Uri"

}
