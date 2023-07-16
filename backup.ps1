# Backup source computer
$sourceComputer = "COMPUTER_NAME" # Replace with the name of the source computer
$backupLocation = "C:\Backup" # Replace with the desired backup location on the source computer

# Backup destination computer
$destinationComputer = "COMPUTER_NAME" # Replace with the name of the destination computer
$restoreLocation = "C:\Restore" # Replace with the desired restore location on the destination computer

# Backup the source computer
Write-Host "Backing up $sourceComputer..."
Start-Process -Wait -NoNewWindow -FilePath "wbadmin" -ArgumentList "start backup -backupTarget:`"$backupLocation`" -include:`"C:`" -quiet"

# Restore to the destination computer
Write-Host "Restoring to $destinationComputer..."
Start-Process -Wait -NoNewWindow -FilePath "wbadmin" -ArgumentList "start recovery -backupTarget:`"$backupLocation`" -machineName:`"$destinationComputer`" -recoveryTarget:`"$restoreLocation`" -quiet"

Write-Host "Backup and restore completed successfully."

