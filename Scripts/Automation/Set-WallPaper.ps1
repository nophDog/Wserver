function Set-WallPaper{
    param(
        [Parameter(Mandatory=$true)]
        [ValidateScript({
            Test-Path -Path $_ -PathType Leaf
        })]
        [String]
        $PicPath
    )
    
    Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name 'WallPaper' -Value $PicPath

    # update user profile to make take effect
    Start-Sleep -Seconds 5
    rundll32.exe USER32.DLL, UpdatePerUserSystemParameters ,1 ,True

}
