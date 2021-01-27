Set-Location C:\Users\admin\Desktop\section1

.\Get-DirStats.ps1 C:\Users\admin\Downloads |Sort-Object -Descending files


get-help Stop-Service -Examples

Get-Service -DisplayName "Windows Search" | Stop-Service -Force -Confirm

Get-Service -DisplayName "Windows Search" | restart-Service -Force