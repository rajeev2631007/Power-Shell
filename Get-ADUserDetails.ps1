<#
.SYNOPSIS
    This script retrieves all domain users along with their personal attributes and group memberships from an Active Directory domain.

.DESCRIPTION
    The script uses the Active Directory module to query all users in the domain and then retrieves their personal attributes and group memberships. The results are outputted in a structured format and can be exported to a CSV file.

.PARAMETER OutputFilePath
    The file path where the results will be exported to a CSV file.

.NOTES
    Author: ChatGPT
    Date: 2024-07-20
#>

param (
    [Parameter(Mandatory=$true)]
    [string]$OutputFilePath
)

# Import the Active Directory module
Import-Module ActiveDirectory

# Function to retrieve user details and group memberships
function Get-UserDetails {
    param (
        [string]$UserName
    )

    # Get user details
    $user = Get-ADUser -Identity $UserName -Properties DisplayName, EmailAddress, Department, Title

    # Get user group memberships
    $groups = Get-ADUser -Identity $UserName -Properties MemberOf | Select-Object -ExpandProperty MemberOf

    # Join group names into a single string
    $groupNames = ($groups | Get-ADGroup | Select-Object -ExpandProperty Name) -join ", "

    # Output user details and group memberships
    [PSCustomObject]@{
        UserName     = $user.SamAccountName
        DisplayName  = $user.DisplayName
        EmailAddress = $user.EmailAddress
        Department   = $user.Department
        Title        = $user.Title
        Groups       = $groupNames
    }
}

# Retrieve all users in the domain
$allUsers = Get-ADUser -Filter *

# Iterate through each user and retrieve details and group memberships
$userDetailsList = foreach ($user in $allUsers) {
    Get-UserDetails -UserName $user.SamAccountName
}

# Output the results to a CSV file
$userDetailsList | Export-Csv -Path $OutputFilePath -NoTypeInformation

Write-Output "User details and group memberships have been exported to $OutputFilePath"

------------------------------------------------------------------------------------------------------------------------------------
#Change Directory
cd C:\Users\Administrator.AXDC\Desktop\Script\
#Example
.\Get-ADUserDetails.ps1 -OutputFilePath "C:\path\to\output\ADUserDetails.csv"

----------------------------------------------------------------------------------------------------------------------------------
Script Explanation:

    param: Defines a mandatory parameter $OutputFilePath for the script, which specifies where the results will be exported.
    Import-Module ActiveDirectory: Ensures the Active Directory module is loaded.
    Get-UserDetails Function:
        Takes a username as a parameter.
        Retrieves user details (DisplayName, EmailAddress, Department, Title) using Get-ADUser.
        Retrieves the groups the user is a member of using Get-ADUser with the MemberOf property.
        Joins the group names into a single string.
        Returns a custom PowerShell object with user details and group memberships.
    **Get-ADUser -Filter ***: Retrieves all users from the Active Directory.
    Foreach Loop: Iterates through each user and retrieves details and group memberships using the Get-UserDetails function.
    Export-Csv: Exports the results to the specified CSV file.
    Write-Output: Provides a message indicating the export location of the results.

Usage:

To use this script, save it as a .ps1 file (e.g., Get-ADUserDetails.ps1) and run it from a PowerShell session, specifying the output file path as a parameter:

