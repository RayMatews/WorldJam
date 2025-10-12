$timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
Copy-Item "C:\chemin\vers\worldjam_new_fixed" "D:\Backups\worldjam_$timestamp" -Recurse
