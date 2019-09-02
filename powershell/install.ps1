$config = Get-Content config.json | ConvertFrom-Json

# copy profile file
Copy-Item ./data/profile.ps1 $profile

# create startup script
Copy-Item ./data/startup.ps1 "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup\startup.ps1"
"@ECHO OFF`nPowerShell.exe -Command `"./startup.ps1`"`nPAUSE" > "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup\startup.bat"
