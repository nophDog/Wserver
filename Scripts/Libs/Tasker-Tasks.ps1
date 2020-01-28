function Tasker-Tasks($backupXml){

    ([xml](Get-Content -Path $backupXml) | Select-Xml -XPath '/TaskerData/Task/nme').Node.InnerText |
    Out-File -FilePath "$env:USERPROFILE\Downloads\Tasker Tasks.txt"

}

Tasker-Tasks $args[0]
