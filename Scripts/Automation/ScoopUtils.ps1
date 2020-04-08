function script:Trace-Word
{
    [Cmdletbinding()]
    [Alias("Highlight")]
    Param(
            [Parameter(ValueFromPipeline=$true, Position=0)]
            [string[]] $Content,
            [Parameter(Position=1)]
            [ValidateNotNull()]
            [String[]] $Words = $(throw "Provide word[s] to be highlighted!")
    )

    Begin
    {

        # Modified By re0j @ 2019-12-17 20:02:19
        Function paletteConst{

            [System.Collections.ArrayList]$palette = @('DarkBlue','DarkGreen','DarkCyan', `
                                        'DarkRed','DarkMagenta','DarkYellow','DarkGray',  `
                                        'Blue','Green','Cyan','Red','Magenta','Yellow')

            $paletteDict = @{}

            For($i=0; $i -lt 13; $i++) {
                # index to pick
                if (($palette.Count -1) -eq 0) {
                    $init = 0
                } else {
                    $init = Get-Random -Minimum 0 -Maximum ($palette.Count - 1)
                }

        # tpido
                    $picked = $palette[$init]

                    # assign it to hashtable with ordered index
                    $paletteDict[$i] = $picked

                    # remove picked from original arraylist
                    $palette.Remove($picked)
                }

                return $paletteDict
            }

        $Color = paletteConst
        # Modify END

        # $Color = @{
                    # 0='Yellow'
                    # 1='Magenta'
                    # 2='Red'
                    # 3='Cyan'
                    # 4='Green'
                    # 5 ='Blue'
                    # 6 ='DarkGray'
                    # 7 ='Gray'
                    # 8 ='DarkYellow'
                    # 9 ='DarkMagenta'
                    # 10='DarkRed'
                    # 11='DarkCyan'
                    # 12='DarkGreen'
                    # 13='DarkBlue'
        # }

        $ColorLookup =@{}

        For($i=0; $i -lt $words.count; $i++)
        {
            if($i -eq 13)
            {
                $j = 0
            }
            else
            {
                $j = $i
            }

            $ColorLookup.Add($words[$i],$Color[$j])
            $j++
        }

    }
    Process
    {
    $content | ForEach-Object {

        $TotalLength = 0

        $_.split() | `
        Where-Object {-not [string]::IsNullOrWhiteSpace($_)} | ` #Filter-out whiteSpaces
        ForEach-Object{
                        if($TotalLength -lt ($Host.ui.RawUI.BufferSize.Width-10))
                        {
                            #"TotalLength : $TotalLength"
                            $Token =  $_
                            $displayed= $False

                            Foreach($Word in $Words)
                            {
                                if($Token -like "*$Word*")
                                {
                                    $Before, $after = $Token -Split "$Word"


                                    #"[$Before][$Word][$After]{$Token}`n"

                                    Write-Host $Before -NoNewline ;
                                    Write-Host $Word -NoNewline -Fore Black -Back $ColorLookup[$Word];
                                    Write-Host $after -NoNewline ;
                                    $displayed = $true
                                    #Start-Sleep -Seconds 1
                                    #break
                                }

                            }
                            If(-not $displayed)
                            {
                                Write-Host "$Token " -NoNewline
                            }
                            else
                            {
                                Write-Host " " -NoNewline
                            }
                            $TotalLength = $TotalLength + $Token.Length  + 1
                        }
                        else
                        {
                            Write-Host '' #New Line
                            $TotalLength = 0

                        }

                            #Start-Sleep -Seconds 0.5

        }
        Write-Host '' #New Line
    }
    }
    end
    {    }

}


function script:Update-NotInstalled {
    $installed = scoop export | ForEach-Object { ($_ -split ' ')[0] }
    (Get-ChildItem -Path $env:SCOOP\buckets -Recurse -Filter '*.json').BaseName |
    Where-Object -FilterScript { $_ -notin $installed } | Out-File -FilePath "$env:SCOOP\notinstalled.app"
}

function script:Update-Installed {
    scoop export | ForEach-Object { ($_ -split ' ')[0] } | Out-File -FilePath "$env:SCOOP\installed.app"
}


# SCOOP SEARCH <PACKAGE>
function ss{
    param(
        [Parameter(Mandatory)]
        [string[]]
        $Keyword,

        [switch]
        $Dsrip,

        [switch]
        $Regex

    )

    $installedSign = [char]::ConvertFromUtf32(0x1F197)

    # keyword pattern constructor
    function patternConst($KeywordList){

        return '(' + ($KeywordList -join '|') + ')'
    }

    $pattern = patternConst($Keyword)

    # . $env:USERPROFILE\Documents\Scripts\Libs\Trace-Word.ps1
    if ($Dsrip) {

        $right = [char]::ConvertFromUtf32(0x1F449) # 👉

        # Search In Also Comment
        Get-ChildItem -Path "$env:SCOOP\buckets" -Recurse -Filter '*.json' |
            ForEach-Object { $_.BaseName + " $right " + (Get-Content -Path $_.FullName |
                ConvertFrom-Json).description} |
                    Where-Object -FilterScript { $_ -imatch $pattern } |
                        Tee-Object -Variable total |
                            Trace-Word -Words $Keyword

    } else {

    (Get-ChildItem -Path "$env:SCOOP\buckets\" -Recurse -File -Filter '*.json').BaseName |
        Where-Object {$_ -imatch $pattern} |
            Tee-Object -Variable total |
                Sort-Object -Property Length |
                    ForEach-Object { ($_ -in (Get-Content -Path "$env:SCOOP\installed.app")) ? $_ + " $installedSign" : $_ } |
                        Trace-Word -Words $Keyword

    }


    # Summary
    if ($total.Count -eq 0) {
        Write-Host -Object 'No related program found :(' -BackgroundColor Red -ForegroundColor White
    } else {

        $result = "`nTotal: " + $total.Count
        Write-Host -Object $result -BackgroundColor White -ForegroundColor Black
    }

}


# SCOOP INSTALL <PACKAGE>
function sii {

    param(
        [Parameter(Mandatory=$true)]
        [ArgumentCompleter(
            {
                param($Command, $Parameter, $WordToComplete, $CommandAst, $FakeBoundParams)
                Get-Content -Path "$env:SCOOP\notinstalled.app" |
                    Where-Object -FilterScript { $_.StartsWith($WordToComplete, "CurrentCultureIgnoreCase") }
            }
        )]
        $Package,

        [ValidateSet('32bit','64bit')]
        $Arch=((Get-CimInstance CIM_OperatingSystem).OSArchitecture -replace '-','')
        # https://ridicurious.com/2018/10/17/4-ways-to-find-os-architecture-using-powershell-32-or-64-bit/
    )

    scoop install $Package --arch $Arch

    Update-NotInstalled
    Update-Installed
}


# SCOOP UPDATE
function su {
    scoop update
    Update-NotInstalled
}


# SCOOP UPDATE *
function suu {
    scoop update *
    Update-NotInstalled
}


# SCOOP BUCKET LIST
function sbl {
    scoop bucket list
}


# SCOOP BUCKET ADD <BUCKET>
function sba {
    scoop bucket add
    Update-NotInstalled
}


# SCOOP INFO <PACKAGE>
function sci {
    param(
        [Parameter(Mandatory=$true)]
        [ArgumentCompleter(
            {
                param($Command, $Parameter, $WordToComplete, $CommandAst, $FakeBoundParams)
                Get-Content -Path "$env:SCOOP\installed.app", "$env:SCOOP\notinstalled.app" |
                    Where-Object -FilterScript { $_.StartsWith($WordToComplete, "CurrentCultureIgnoreCase") }
            }
        )]
        $Package
    )

    scoop info $Package
}


# SCOOP UNINSTALL <PACKAGE>
function sui {
    param(
        [Parameter(Mandatory=$true)]
        [ArgumentCompleter(
            {
                param($Command, $Parameter, $WordToComplete, $CommandAst, $FakeBoundParams)
                Get-Content -Path "$env:SCOOP\installed.app" |
                    Where-Object -FilterScript { $_.StartsWith($WordToComplete, "CurrentCultureIgnoreCase") }
            }
        )]
        $Package
    )

    scoop uninstall $Package

    Update-NotInstalled
    Update-Installed
}

# if scoop is installed
if (-not (Get-Command -Name scoop -ErrorAction Ignore)) {Write-Host -Object 'Scoop is not installed'; exit}

# init when first import
if (Test-Path -Path $env:SCOOP) {
    if (-not ((Test-Path -Path "$env:SCOOP\installed.app") -or (Test-Path -Path "$env:SCOOP\notinstalled.app"))) {
        Update-NotInstalled
        Update-Installed
    }
} else {
    Write-Host -Object 'Note: set SCOOP environment variable first' -BackgroundColor Red -ForegroundColor White
}