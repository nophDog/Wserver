$scriptBlock0 = {
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameters)

    @('step','song','people','pssRepo') |
    Where-Object -FilterScript {$_ -ilike "$wordToComplete*"}
}

Register-ArgumentCompleter -CommandName Find-LiteDBDocument -ParameterName Collection -ScriptBlock $scriptBlock0

$scriptBlock1 = {
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameters)

    (Get-ChildItem -Path "$env:USERPROFILE\Documents\MyLiteDB").FullName |
    Where-Object -FilterScript {$_ -ilike "$wordToComplete*"}
}

Register-ArgumentCompleter -CommandName Open-LiteDBConnection -ParameterName Database -ScriptBlock $scriptBlock1