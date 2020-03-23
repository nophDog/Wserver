$passwdlitedb = {
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameters)

    @('step','song','people','pssRepo') |
    Where-Object -FilterScript {$_ -ilike "$wordToComplete*"}
}

Register-ArgumentCompleter -CommandName Find-LiteDBDocument -ParameterName Collection -ScriptBlock $passwdlitedb

$litedb = {
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameters)

    (Get-ChildItem -Path "$env:USERPROFILE\Documents\MyLiteDB").FullName |
    Where-Object -FilterScript {$_ -ilike "$wordToComplete*"}
}

Register-ArgumentCompleter -CommandName Open-LiteDBConnection -ParameterName Database -ScriptBlock $litedb

$installedsoftware = {
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameters)

    (Get-InstalledSoftware).Name | 
    Where-Object -FilterScript {$_ -ilike "$wordToComplete*"} |
    ForEach-Object { """$_""" }
}

Register-ArgumentCompleter -CommandName Get-InstalledSoftware -ParameterName Name -ScriptBlock $installedsoftware

$timezone = {
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameters)

    (Get-TimeZone -ListAvailable).Id | Where-Object {
        $_ -like "$wordToComplete*"
    } | ForEach-Object {
          "'$_'"
    }
}
Register-ArgumentCompleter -CommandName Set-TimeZone -ParameterName Id -ScriptBlock $timezone

$stoprunning = {
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameters)
    $services = Get-Service | Where-Object {$_.Status -eq "Running" -and $_.Name -like "$wordToComplete*"}
    $services | ForEach-Object {
        New-Object -Type System.Management.Automation.CompletionResult -ArgumentList $_.Name,
            $_.Name,
            "ParameterValue",
            $_.Name
    }
}
Register-ArgumentCompleter -CommandName Stop-Service -ParameterName Name -ScriptBlock $stoprunning