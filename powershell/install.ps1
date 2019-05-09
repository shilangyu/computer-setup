$config = Get-Content config.json | ConvertFrom-Json

Copy-Item ./data/profile.ps1 $profile
