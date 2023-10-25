# Import the required modules
Import-Module NetSecurity

# Disable the Firewall
Disable-NetFirewallProfile -Profile Domain,Public,Private
