﻿Function Get-FolderSize 
{
<#
.SYNOPSIS
Get-FolderSize will recursively search all files and folders at a given path to show the total size

.DESCRIPTION
Get-FolderSize accepts a file path through the Path parameter and then recursively searches the directory in order to calculate the overall file size. 
The size is displayed in GB, MB, or KB depending on the Unit selected, defaults to GB.  Will accept Multiple paths.

.EXAMPLE 
Get-FolderSize -path C:\users\Someuser\Desktop

Returns the size of the desktop folder in Gigabytes

.EXAMPLE 
Get-FolderSize -path \\Server\Share\Folder, c:\custom\folder -unit MB

Returns the size of the folders, \\Server\Share\Folder and C:\Custom\Folder, in Megabytes

#>
[CmdletBinding()]
Param
    (
        # Enter the path to the target folder
        [Parameter(
        ValueFromPipeline=$True, 
        ValueFromPipelineByPropertyName=$True,
        Mandatory=$true,
        HelpMessage= 'Enter the path to the target folder'
        )]
        [ValidateScript({Test-Path $_})]
        [String[]]$Path,
        # Set the unit of measure for the function, defaults to GB, acceptable values are GB, MB, and KB
        [Parameter(
        HelpMessage="Set the unit of measure for the function, defaults to GB, acceptable values are GB, MB, and KB")]
        [ValidateSet('GB','MB','KB')]
        [String]$Unit = 'GB'
    )
Begin 
    {
        Write-Verbose "Setting unit of measure"
        $value = Switch ($Unit)
            {
                'GB' {1GB}
                'MB' {1MB}
                'KB' {1KB}
            }
    }
Process
    {
        Foreach ($FilePath in $Path)
            {
                Try
                    {
                        Write-Verbose "Collecting Foldersize"
                        $Size = Get-ChildItem $FilePath -Force -Recurse -ErrorAction Stop | Measure-Object -Property length -Sum
                    }
                Catch
                    {
                        Write-Warning $_.Exception.Message
                        $Problem = $True
                    }
                If (-not($Problem))
                    {
                        Try 
                            {
                                Write-Verbose "Creating Object"
                                New-Object -TypeName PSObject -Property @{
                                        FolderName = $FilePath
                                        FolderSize = "$([math]::Round(($size.sum / $value), 2)) $($unit.toupper())"
                                    }
                            }
                        Catch 
                            {
                                Write-Warning $_.Exception.Message
                                $Problem = $True
                            }
                    }
                if ($Problem) {$Problem = $false}
            }
    }
End{}
}