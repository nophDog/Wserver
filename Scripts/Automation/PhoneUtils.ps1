## Date 👉🏻 2020-01-13 23:47:45
## Author 👉🏻 Mr.ZENG
## Description 👉🏻 Get Phone Information From CSV File From Google Contacts Exports
## Require 👉🏻 pypinyin.exe, PSLiteDB


function Register-PhoneLiteDB {
	Param(
        [Parameter(Mandatory=$true)]
        [ValidateScript(
            {
                (Test-Path -Path $_ -PathType Leaf) -and ($_.EndsWith('csv'))
            }
        )]
        $Path,
        
        [ValidateScript(
            {
                Test-Path -Path $_ -PathType Leaf
            }
        )]
        $Database="$env:USERPROFILE\Documents\MyLiteDB\refer.db",

        [string]
        $Collection='people'
	)

    Open-LiteDBConnection -Database $Database
    New-LiteDBCollection -Collection $Collection

    Get-Content -Path $Path |
    ConvertFrom-Csv |
    ForEach-Object { @{'_id'=$_.Name;'abbr'=((pypinyin.exe --style 'FIRST_LETTER' $_.Name) -replace ' ','');'number'=($_.'Phone 1 - Value' -replace ' ','')} |
    ConvertTo-LiteDbBSON |
    Add-LiteDBDocument -Collection $Collection}

    Close-LiteDBConnection

}

function Find-Phone {
	Param(
		[ValidateSet('_id','abbr','number')]
	    $Field='abbr',
        
        [Parameter(Position=0)]
        $Pattern,

        [ValidateScript(
            {
                Test-Path -Path $_ -PathType Leaf
            }
        )]
        $Database="$env:USERPROFILE\Documents\MyLiteDB\refer.db",

        $Collection='people'
	)

    Open-LiteDBConnection -Database $Database | Out-Null

    Find-LiteDBDocument -Collection $Collection |
    Where-Object -FilterScript { $_.$Field -imatch "$Pattern" }

    Close-LiteDBConnection
}
