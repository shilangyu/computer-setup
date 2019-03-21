$config = Get-Content config.json | ConvertFrom-Json

# extentions
foreach ($name in $config.extensions) {
	code --install-extension $name
}

# settings
Copy-Item .\data\settings.json -Destination $env:APPDATA\Code\User

# keybindings
Copy-Item .\data\keybindings.json -Destination $env:APPDATA\Code\User

# snippets
New-Item $env:APPDATA\Code\User\snippets -ItemType Directory
Get-ChildItem .\data\snippets | Select-Object Name | ForEach-Object {
	Copy-Item .\data\snippets\$($_.Name) -Destination $env:APPDATA\Code\User\snippets\$($_.Name)
}
