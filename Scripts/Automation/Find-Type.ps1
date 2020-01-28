function Find-Type {
	Param(
		[regex]
        $Pattern
	)

    [System.AppDomain]::CurrentDomain.GetAssemblies().GetTypes() |
    Select-String $Pattern
}
