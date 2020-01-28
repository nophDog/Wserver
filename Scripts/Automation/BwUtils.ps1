## Date 👉🏻 2020-01-15 21:56:00
## Author 👉🏻 Mr.ZENG
## Require 👉🏻 PSLiteDB, bw.exe, pypinyin.exe


function Register-BwLiteDB {
	Param(
        [ValidateScript(
            {
                Test-Path -Path $_ -PathType Leaf
            }
        )]
		$DataBase,
        
        [string]
        $Collection
	)
    
    if (Get-Command -Name pypinyin -ErrorAction Ignore) {
        } else {
        Write-Host -Object 'Install program pypinyin first.' -ForegroundColor Red
        echo 'Exiting'
        return

        }

    Open-LiteDBConnection -Database $DataBase

    New-LiteDBCollection -Collection $Collection

    bw list items --session $env:BW_SESSION |
    ConvertFrom-Json |
    ForEach-Object { @{'_id'=$_.name; 'username'=$_.login.username; 'password'=$_.login.password; 'notes'=$_.notes; 'abbr'=((pypinyin.exe --style 'FIRST_LETTER' $_.name) -replace ' ','')} |
    ConvertTo-LiteDbBSON |
    Add-LiteDBDocument -Collection $Collection}

    Close-LiteDBConnection
}

function Find-BwItem {
	Param(
        [ValidateSet('_id','abbr','username','password')]
	    $Field='abbr',
        
        [Parameter(Position=0)]
        $Pattern,

        [ValidateScript(
            {
                Test-Path -Path $_ -PathType Leaf
            }
        )]
        $Database="$env:USERPROFILE\Documents\MyLiteDB\refer.db",

        $Collection='pssRepo'
	)

    Open-LiteDBConnection -Database $Database | Out-Null

    Find-LiteDBDocument -Collection $Collection |
    Where-Object -FilterScript { $_.$Field -imatch "$Pattern" }

    Close-LiteDBConnection
}


## Last Modified 👉🏻 2020-01-15 22:49:04