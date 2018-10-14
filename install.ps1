Set-Location .\programs
& .\install.ps1
Set-Location ..

Get-ChildItem -Directory | ForEach-Object {
	If($_.Name -ne "programs") {
		Set-Location .\$($_.Name)
		& .\install.ps1
		Set-Location ..
	}
}
