## Date 👉🏻 2020-01-15 22:14:47
## Author 👉🏻 Mr.ZENG
## Description 👉🏻 

function Test-Command {
	Param(
		[Parameter(Mandatory=$true)]
        $Command
	)

    If (Get-Command -Name $Command -ErrorAction Ignore) {
        return $true
    } else {
        return $false
    }

}

## Last Modified 👉🏻 2020-01-15 22:32:23