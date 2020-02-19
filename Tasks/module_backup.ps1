Import-Module -Name PoshGram

$modulesDir = "$env:USERPROFILE\Wserver\"
$modules = 'requiredModules.txt'

(Get-InstalledModule).Name | Out-File -FilePath $("$modules" + $modules) -Force

cd $($modulesDir + 'Tasks')
git add 'requiredModules.txt'
git commit -m "Modules list backde up @ $(Get-Date)"
git push

## Send notification to Telegram
$token = '573256238:AAGawSaI8R0V-y3gMxmV99Fr4ytXcbnX5vQ'
$chatid = '280717132'
Send-TelegramTextMessage -BotToken $token -ChatID $chatid -Message "Modules list backde up @ $(Get-Date)"
