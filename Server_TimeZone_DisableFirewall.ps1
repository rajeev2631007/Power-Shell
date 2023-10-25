# Import the required modules
Import-Module TimeZone
Import-Module NetSecurity

# Get the current server name
$currentServerName = Get-ComputerName -Name

# Set the new server name
Set-ComputerName -Name "NewServerName"

# Disable the Firewall
Disable-NetFirewallProfile -Profile Domain,Public,Private

# Set the time zone to India
Set-TimeZone "India Standard Time"

# Display a message
Write-Host "The server name has been changed to NewServerName. The Firewall has been disabled. The time zone has been set to India Standard Time."
