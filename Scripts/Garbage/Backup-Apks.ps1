function Backup-Apks {
    
    Param(
        [Parameter(mandatory=$true)]$FullApkPath,
        [Parameter(mandatory=$true)]$PartApkPath
    )

    If ((Test-Path -Path $FullApkPath) -and (Test-Path -Path $PartApkPath)) {
        
        ## [ABANDONDED] using **ArrayList** because the simple array object has a fixed size
        $fullApks= @{}
        $partApks= @{}

        # Gather apk names in **FULL APK PATH**
        foreach ($apk in (Get-ChildItem -Path $FullApkPath)) {
            $fullApks.(@($apk.BaseName.Split("-"))[0]) = $apk.FullName
        }

        # Gather apk names in **PART APK PATH**
        foreach ($apk in (Get-ChildItem -Path $PartApkPath)) {
            $partApks.(@($apk.BaseName.Split("-"))[0]) = $apk.FullName
        }

        # Compare each name in each array
        foreach ($apkItem in $partApks.Keys) {
            
            # check if newly added apk exists
            if ($apkItem -in $fullApks.Keys) {
                
                # exists
                $fullApks.Remove($apkItem)
                # Remove-Item -Path $fullApks.$apkItem
            } Else {
                # not exists
            }
        }

        #$fullApks.Keys.Count
        #$partApks.Keys.Count

        $i = 1
        foreach ($apk in $fullApks.Keys) {Write-Progress -Activity "Moving $fullApks.$apk to $PartApkPath" -Status "File $i of $fullApks.Count" -PercentComplete (($i / $fullApks.Count) * 100); Move-Item -Path $fullApks.$apk -Destination $PartApkPath; $i++}
        Remove-Item -Path $FullApkPath -Recurse
        Rename-Item -Path $PartApkPath -NewName "APKS_BACKUP (newest)"

        Write-Host "Done!"


    } Else {

        Write-Error "Not valid path"
    
    }
}