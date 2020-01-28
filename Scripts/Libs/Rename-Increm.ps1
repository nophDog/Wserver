function Rename-Increm{
    param(
        [Parameter(Mandatory=$true,Position=1)]
        $Path=$(Get-Location),

        [Parameter(Mandatory=$true,Position=2)]
        $Prefix,

        [int]
        $StartFrom=1,

        [int]
        $Step=1,

        $Delimiter=' '
        
    )

    $files = @(Get-ChildItem -Path .)

    for (($i=0$id=1); ($i -lt ($(Get-ChildItem -Path $Path).Length)); $i += $Step) {
    $files[$i] | Rename-Item -NewName "$Prefix$Delimiter$($i+1).png"
    }
}