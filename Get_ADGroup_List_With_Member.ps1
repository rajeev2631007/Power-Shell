<#
.SYNOPSIS
    This script retrieves all groups and their members from an Active Directory domain and exports the results to a specified CSV file.

.DESCRIPTION
    The script uses the Active Directory module to query all groups in the domain and then retrieves the members of each group. The results are outputted in a structured format and exported to a CSV file.

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

# Function to retrieve group members
function Get-GroupMembers {
    param (
        [string]$GroupName
    )

    # Get members of the group
    $groupMembers = Get-ADGroupMember -Identity $GroupName -ErrorAction SilentlyContinue

    if ($groupMembers) {
        foreach ($member in $groupMembers) {
            # Output group member details
            [PSCustomObject]@{
                GroupName  = $GroupName
                MemberName = $member.Name
                MemberType = $member.objectClass
            }
        }
    } else {
        # Output group with no members
        [PSCustomObject]@{
            GroupName  = $GroupName
            MemberName = "No members"
            MemberType = "N/A"
        }
    }
}

# Retrieve all groups in the domain
$allGroups = Get-ADGroup -Filter *

# Iterate through each group and retrieve its members
$groupMembersList = foreach ($group in $allGroups) {
    Get-GroupMembers -GroupName $group.Name
}

# Output the results to a CSV file
$groupMembersList | Export-Csv -Path $OutputFilePath -NoTypeInformation

Write-Output "Group members have been exported to $OutputFilePath"
----------------------------------------------------------------------------------------------------------

#Change Directory
cd C:\Users\Administrator.AXDC\Desktop\Script\
#Example
.\Get-ADUserDetails.ps1 -OutputFilePath "C:\path\to\output\ADUserDetails.csv"

----------------------------------------------------------------------------------------
Script Explanation:

    param: Defines a mandatory parameter $OutputFilePath for the script, which specifies where the results will be exported.
    Import-Module ActiveDirectory: Ensures the Active Directory module is loaded.
    Get-GroupMembers Function: Takes a group name as a parameter and retrieves its members. It returns a custom PowerShell object with group name, member name, and member type.
    **Get-ADGroup -Filter ***: Retrieves all groups from the Active Directory.
    Foreach Loop: Iterates through each group and retrieves its members using the Get-GroupMembers function.
    Export-Csv: Exports the results to the specified CSV file.
    Write-Output: Provides a message indicating the export location of the results.

This script allows you to dynamically specify the path where the CSV file will be saved.
