# backup current configuration for windows services
$filename = "$env:USERPROFILE\Desktop\Backup_Windows-Services_Current-State.reg"
"Windows Registry Editor Version 5.00" | Out-File $filename -Encoding ASCII
Get-Service | Where-Object {$_.Name -cmatch "[a-z]" -and $_.Name -ne "TermService"} | ForEach-Object {
    $svc = $_.Name
    $start = Get-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\$svc" -Name Start -ErrorAction SilentlyContinue | Select-Object -ExpandProperty Start
    if ($start -match "[0-4]$") {
        $start = [int]$start
        "`n[$('HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\'+$svc)]" | Out-File $filename -Encoding ASCII -Append
        "`"Start`"=dword:0000000$($start)" | Out-File $filename -Encoding ASCII -Append
    }
} > $null