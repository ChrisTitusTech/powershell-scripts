# backup current configuration for drivers services
$filename = "$env:USERPROFILE\Desktop\Backup_Drivers-Services_Current-State.reg"
$regHeader = 'Windows Registry Editor Version 5.00'

Set-Content $filename $regHeader

driverquery /FO CSV | ForEach-Object {
    $svc = $_.Split(",")[0].Trim('"')
    $start = (Get-ItemProperty "HKLM:\SYSTEM\CurrentControlSet\Services\$svc" -Name Start -ErrorAction SilentlyContinue).'Start'
    if ($start -match "[0-4]$") {
        $start = [int]$start
        $regKey = "[$('HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\'+$svc)]"
        $regValue = "`"Start`"=dword:0000000$start"
        $regEntry = "$regKey`n$regValue`n$regDelimiter"
        Add-Content $filename $regEntry
    }
} > $null 2>&1
