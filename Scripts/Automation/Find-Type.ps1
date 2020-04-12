function Find-Type {
	Param(
		[regex]
        $Pattern
	)

    ([System.AppDomain]::CurrentDomain.GetAssemblies().GetTypes()).Name |
    Select-String $Pattern
}
