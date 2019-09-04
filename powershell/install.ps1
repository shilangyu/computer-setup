$config = Get-Content config.json | ConvertFrom-Json

# copy profile file
Copy-Item ./data/profile.ps1 $profile

# create startup script
$startupPath = "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup"
Copy-Item ./data/startup.ps1 "$startupPath/startup.ps1"
[IO.File]::WriteAllLines("$startupPath/startup.bat", "@ECHO OFF`nPowerShell.exe -Command `"& '$startupPath/startup.ps1'`"")
