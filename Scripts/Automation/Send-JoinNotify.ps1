Function Send-JoinNotify {
    [CmdletBinding()]
    Param(

        [Parameter(Mandatory=$false,
        HelpMessage='Enter the title of your nofification.')]
        [String]
        $Title='From my PowerShell',

        [Parameter(Mandatory=$true,
        HelpMessage='Enter the text of your nofification.')]
        [String]
        $Text,

        [String]
        $IconUrl='',
        
        [String]
        $StatusBarIconUrl='https://i.loli.net/2019/11/13/49GpVwnPJNbZ5cd.png',

        [String]
        $Url='',

        [String]
        $ImageUrl='',

        [Switch]
        $AsClipboard,

        [ValidateSet('OnePlus5T','NodeRed')]
        $Device='OnePlus5T'
    )

    Begin {
        # devices'ids
        $oneplus = 'f30bf113d1684dd69de19b87b822bc68'
        $nodered = 'dc51b8c7159d4942b53ebad3a87e6ba4'

        switch ($Device) {
            'OnePlus5T' {$deviceId = $oneplus}
            'NodeRed' {$deviceId = $nodered}
        }

        # build the pending url
        $hookUrl = 'https://joinjoaomgcd.appspot.com/_ah/api/messaging/v1/sendPush?'
        $query = "deviceId=$deviceId&title=$Title&text=$Text&icon=$IconUrl&smallicon=$StatusBarIconUrl&url=$Url&image=$ImageUrl&apikey=d484a8d19a2f4063a9ba3229837d881f"

        # for url encoding use
        function str_encode {
            param (
               $input_str 
            )
            return [uri]::EscapeUriString($input_str)
        }

    }

    Process {
        if ($AsClipboard) {
            $notifyurl = $hookUrl + (str_encode("$query")) + "&clipboard=" + (str_encode("$Text"))
        } else {
            $notifyurl = $hookUrl + (str_encode("$query"))    
        }

        $send = Invoke-WebRequest -Uri $notifyurl -Method Post -UseBasicParsing
    }

    End {
        if ($send.StatusCode -eq 200) {
            Write-Host -Object "Notification send successfully!" -ForegroundColor Green
        } else {
            Write-Host -Object "Failed to send notification, try again." -ForegroundColor Red
        }
    }

}
