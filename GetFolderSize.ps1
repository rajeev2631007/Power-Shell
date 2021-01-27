"{0:N2} MB" -f ((Get-ChildItem C:\users\ -Recurse | Measure-Object -Property Length -Sum -ErrorAction Stop).Sum / 1MB)



get-childitem 'D:\dump' -recurse -force | where-object { $_.FullName.Length } | select-object FullName | export-csv c:\test.csv



$fso = new-object -com Scripting.FileSystemObject
gci -Directory `
  | select @{l='Size'; e={$fso.GetFolder($_.FullName).Size}},FullName `
  | sort Size -Descending `
  | ft @{l='Size [MB]'; e={'{0:N2}    ' -f ($_.Size / 1MB)}},FullName