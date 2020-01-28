function Invoke-Quicker {
    param (
        [Parameter(Mandatory=$true)]
        [String]
        $ActionID
    )

    $quickerExe = "$env:ProgramFiles\Quicker\QuickerStarter.exe"

    & $quickerExe runaction:$ActionID
}
