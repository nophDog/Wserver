$count = -31

Open-LiteDBConnection -Database 'C:\Users\Reno\Documents\MyLiteDB\body.db'

Get-Content -Path 'C:\Users\Reno\Documents\step.txt' |
% { [pscustomobject]@{'day'=(Get-Date).AddDays($count).AddHours(9).AddMinutes(-4).AddSeconds((Get-Random -Maximum 20 -Minimum 1)).ToString("M/d/yyyy HH:mm:ss")
    'step'=$_.ToString()} |
ConvertTo-LiteDbBSON |
Add-LiteDBDocument -Collection step;
$count += 1 }

Close-LiteDBConnection