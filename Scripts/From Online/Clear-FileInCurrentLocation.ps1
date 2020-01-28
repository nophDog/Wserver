function Get-ValidValues {
    [CmdletBinding()]
    param($Path)

    (Get-ChildItem -Path $Path -File).Name
}

function Clear-FileInCurrentLocation {
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
    param(
        [Parameter(Position = 0, Mandatory)]
        [ArgumentCompleter(
            {
                param($Command, $Parameter, $WordToComplete, $CommandAst, $FakeBoundParams)

                Get-ValidValues -Path (Get-Location)
            }
        )]
        [ValidateScript(
            {
                $_ -in (Get-ValidValues -Path (Get-Location))
            }
        )]
        [string]
        $Path
    )

    Clear-Content -Path $Path
}