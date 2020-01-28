function Get-Venv {

    Get-ChildItem -Path $env:USERPROFILE\.virtualenvs -Recurse -File -Filter '.project' | Get-Content
}


function Invoke-Venv{
    param(
        [Parameter(Mandatory)]
        [ArgumentCompleter(
            {
                param($Command, $Parameter, $WordToComplete, $CommandAst, $FakeBoundParams)
                Get-Venv
            }
        )]
        [ValidateScript(
            {
                $_ -in (Get-Venv)
            }
        )]
        $Venv
    )

    Set-Location -Path $Venv
    pipenv shell

}