# install scoop
Set-ExecutionPolicy Bypass -Scope Process -Force; Invoke-Expression (new-object net.webclient).downloadstring('https://get.scoop.sh')

$config = Get-Content config.json | ConvertFrom-Json

# install programs
foreach ($program in $config.programs) {
	if ($program.params.length -eq 0) {
		choco.exe install $program.name -y
	}
	else {
		choco.exe install $program.name -y --params "$([string]::Join(" ", $program.params))"
	}
}
