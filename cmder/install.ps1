$config = Get-Content config.json | ConvertFrom-Json

# copy settings
Copy-Item ./data/settings.xml ~/scoop/apps/cmder-full/current/vendor/conemu-maximus5/ConEmu.xml
