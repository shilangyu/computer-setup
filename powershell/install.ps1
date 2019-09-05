$config = Get-Content config.json | ConvertFrom-Json

# copy profile file
Copy-Item ./data/profile.ps1 $profile

# create startup script
Copy-Item ./data/startup.ps1 ~
[IO.File]::WriteAllLines("$env:APPDATA/Microsoft/Windows/Start Menu/Programs/Startup/startup.bat", "@ECHO OFF`nPowerShell.exe -Command `"~/startup.ps1`"")
