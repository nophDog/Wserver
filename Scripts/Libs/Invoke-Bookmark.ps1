## Date 👉🏻 2019-10-03 21:51:21
## Author 👉🏻 Mr.ZENG
## Description 👉🏻 Open a selected bookmark in Chrome

function Invoke-Bookmark {
    $bookmark = Get-Content -Path 'D:\Nuts\Windows\QuteBrowser\config\bookmarks\urls' | % { ($_.split(' '))[0] } | peco
	
	if (-not ($bookmark.Length -eq 0))
	{
		& "D:\UserC\Vivaldi\Application\vivaldi.exe" $bookmark
	}
	
}

Invoke-Bookmark

## Last Modified 👉🏻 2019-12-17 20:16:05
