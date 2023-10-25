New-WebAppPool -Name "MyAppPool"
New-Website -Name "MyWebsite" -PhysicalPath "C:\MyWebsite" -Port 80 -ApplicationPool "MyAppPool"
