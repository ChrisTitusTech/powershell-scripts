# Welcome text
Write-Host "Avilable on Github: https://github.com/ChrisTitusTech/powershell-scripts"

# Backup source computer
$sourceComputer = $env:COMPUTERNAME # Grabs the name of the source computer
$backupLocation = "C:\Backup" # Replace with the desired backup location on the source computer

# Backup destination computer
$destinationComputer = "COMPUTER_NAME" # Replace with the name of the destination computer
$restoreLocation = "C:\Restore" # Replace with the desired restore location on the destination computer

# Prompts
$Mode = Read-Host "Manual input? (Y/n)"
if($Mode -eq "Y"){
    Read-Host -Prompt "Source Computer Name ($sourceComputer)" -OutVariable $tmp
    if($tmp -ne $null){
        $sourceComputer = $tmp
    } else {
        Write-Host "No input entered, exiting"
        Exit
    }
    Read-Host -Prompt "Destination Computer Name ($destinationComputer)" -OutVariable $tmp
    if($tmp -ne $null){
        $destinationComputer = $tmp
    } else {
        Write-Host "No input entered, exiting"
        Exit
    }
}

# Backup the source computer
Write-Host "Backing up $sourceComputer..."
Start-Process -Wait -NoNewWindow -FilePath "wbadmin" -ArgumentList "start backup -backupTarget:`"$backupLocation`" -include:`"C:`" -quiet"

# Restore to the destination computer
Write-Host "Restoring to $destinationComputer..."
Start-Process -Wait -NoNewWindow -FilePath "wbadmin" -ArgumentList "start recovery -backupTarget:`"$backupLocation`" -machineName:`"$destinationComputer`" -recoveryTarget:`"$restoreLocation`" -quiet"

# End message
Write-Host "Backup and restore completed successfully."
