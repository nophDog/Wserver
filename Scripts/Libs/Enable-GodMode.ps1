$godModePath = "C:\Users\$env:USERNAME\Desktop\GodMode.{ED7BA470-8E54-465E-825C-99712043E01C}"

if (Test-Path -Path $godModePath -PathType Container) {
    throw 'God Mode already enabled on the machine.'
} else {
    New-Item -Path $godModePath -ItemType Directory
    Write-Host -Object 'God Mode enabled successfully, go to Desktop and check it out!' -ForegroundColor Green
}