# Import the FileSystem module
import-module FileSystem

# Define the variables
$server = "192.168.1.10"
$share = "shared_folder"
$drive = "Z"

# Map the shared drive
New-PSDrive -Name $drive -PSProvider FileSystem -Root "\\$server\$share"

# Display a message
Write-Host "The shared drive has been mapped to drive $drive."
