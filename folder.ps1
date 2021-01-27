$array= @() 
$folder = "C:\Intel" 
Get-ChildItem -Recurse $folder | Where-Object { $_.PSIsContainer } | 
ForEach-Object { 
    $obj = New-Object PSObject  
     
     
    $Size = [Math]::Round((Get-ChildItem -Recurse $_.FullName | Measure-Object Length -Sum -ErrorAction SilentlyContinue).Sum / 1MB, 2) 
        $obj |Add-Member -MemberType NoteProperty -Name "Path" $_.FullName 
         
        $obj |Add-Member -MemberType NoteProperty -Name "SizeMB" $Size 
        $obj |Add-Member -MemberType NoteProperty -Name "DateModified" $_.LastWritetime 
                $array +=$obj 
    } 
 
$array | select Path,SizeMB,DateModified 