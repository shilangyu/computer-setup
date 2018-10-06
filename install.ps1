Get-ChildItem | Select-Object Name | ForEach-Object {
	If($_.Name -match "install.ps1" -or $_.Name -match "README.md") {
	} else {
		Start-Process .\$_.Name\install.ps1
	}
}