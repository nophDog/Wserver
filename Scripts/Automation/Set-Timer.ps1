function Set-Timer {
  [CmdletBinding()]
  Param(
    [string]$Activity,
        [int]$Period = 25
  )

    Start-Sleep -Seconds ($Period*60)
    Send-OSNotification -Title ('{0} min(s)' -f $Period) -Body $Activity
}

