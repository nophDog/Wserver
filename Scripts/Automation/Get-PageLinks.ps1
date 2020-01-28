## Date 👉🏻 2020-01-12 14:03:16
## Author 👉🏻 Mr.ZENG
## Description 👉🏻 Ultilize an api to fetch webpage links

function Get-PageLinks {
	Param(
        [Parameter(Mandatory=$true)]
		$Uri
	)

    (Invoke-WebRequest -Uri "https://api.hackertarget.com/pagelinks/?q=$($Uri.trim())").Content

}

## Last Modified 👉🏻 2020-01-12 14:06:32