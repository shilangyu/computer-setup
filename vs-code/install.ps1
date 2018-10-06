# extentions
$extensions = 'acidic9.p5js-snippets', 'alefragnani.project-manager', 'christian-kohler.path-intellisense', 'gerane.Theme-Gloom', 'hdg.live-html-previewer', 'HookyQR.beautify', 'joelday.docthis', 'ms-python.python', 'ms-vscode.cpptools', 'ms-vscode.Go', 'ms-vscode.PowerShell', 'ms-vsliveshare.vsliveshare', 'PKief.material-icon-theme', 'shd101wyy.markdown-preview-enhanced', 'zhuangtongfa.Material-theme'
foreach ($name in $extensions) {
	code --install-extension $name
}

# settings
Copy-Item .\data\settings.json -Destination $env:APPDATA\Code\User

# keybindings
Copy-Item .\data\keybindings.json -Destination $env:APPDATA\Code\User

# snippets
Get-ChildItem .\data\snippets | Select-Object Name | ForEach-Object {
	Copy-Item .\data\snippets\$_.Name -Destination $env:APPDATA\Code\User\snippets
}
