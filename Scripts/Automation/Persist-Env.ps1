function Persist-Env {
	Param(
        [string]
		$Name,
        
        [string]
        $Value
	)

    [System.Environment]::SetEnvironmentVariable("$Name", "$Value", [System.EnvironmentVariableTarget]::User)
}
