Function Send-PushCut {
    [CmdletBinding()]
    Param(
        [String]
        $Title='From my PowerShell',

        [Parameter(Mandatory=$true,
        HelpMessage='Enter the text of your nofification.')]
        [String]
        $Text,

        [String]
        $Input='',

        [Parameter(Position=4)]
        [ValidateSet('iPad')]
        $Device='iPad'
    )

    Begin {
        # devices'ids
        $ipad = '8qBBDtimGGOSuM3kEvCuO'

        switch ($Device) {
            'iPad' {$deviceId = $ipad}
        }

        # build the pending url
        $hookUrl = "https://api.pushcut.io/$deviceId/notifications/AMessage%20Notifier"
        $query = @{title="$Title";text="$Text";input="$Input"}
    }

    Process {
        $send = Invoke-WebRequest -Uri $hookUrl -Method Post -Body $query -UseBasicParsing
    }

    End {
        if ($send.StatusCode -ne 200) {
            Write-Host -Object "Failed to send notification, try again." -ForegroundColor Red
        }
}}
