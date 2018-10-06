Set-ExecutionPolicy Bypass -Scope Process -Force; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

$config = Get-Content config.json | ConvertFrom-Json

foreach($program in $config.programs) {
	choco install $program
}
