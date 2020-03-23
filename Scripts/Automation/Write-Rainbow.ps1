function Write-Rainbow {
    param (
        [Parameter(ValueFromPipeline=$true,Mandatory=$true)]
        [string]
        $Text
    )

    # init console colors in an array
    $palette = [System.Enum]::GetValues([System.ConsoleColor])

    foreach ($char in $Text.ToCharArray()) {
        Write-Host -Object $char -ForegroundColor $palette[((0..($palette.Length - 1)) | Get-Random)] -NoNewline
    }

}

