function Get-Hitokoto {
    ((Invoke-WebRequest -Uri 'https://v1.hitokoto.cn/').Content | ConvertFrom-Json).hitokoto
}