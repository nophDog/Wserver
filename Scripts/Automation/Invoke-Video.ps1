## Date 👉🏻 2019-09-26 14:42:57
## Author 👉🏻 Mr.ZENG
## Description 👉🏻

function Invoke-Video {
	[CmdletBinding()]
	param (
		[Parameter(ValueFromPipeline=$true,Mandatory=$true)]
        [String]
        $Path,

		[string]
        $Sub='',

        [switch]
        $NoFS
	)

	# 检查文件是否存在以及是否视频文件
	if ((Test-Path -Path $Path -PathType Leaf) -and ((Get-Item -Path $Path).Extension -match '\.(mkv|mp4|webm)'))
	{} Else {
		Write-Host -Object 'Make sure the video is in the right place' -ForegroundColor Red
		break
	}

	$Path = $Path.Replace('`','')

	# 字幕文件
	if ($Sub -eq '') {
        if ($NoFS) {
		    mpv.exe --volume=35 $Path
        } else {
		    mpv.exe -fs --volume=35 $Path
        }
	} Else {
        if ($NoFS) {
            # alternative font KaiTi_GB2312'
		    mpv.exe --volume=35 $Path --sub-file=$Sub --sub-font='Sarasa UI SC'
        } else {
	    	mpv.exe -fs --volume=35 $Path --sub-file=$Sub --sub-font='Sarasa UI SC'
        }
	}
}

## Last Modified 👉🏻 11/19/2019 18:54:23
