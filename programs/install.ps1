Set-ExecutionPolicy Bypass -Scope Process -Force; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

$programs = 'git', 'vscode', 'golang', 'googlechrome', 'nodejs.install', 'python'

foreach($program in $programs) {
	choco install $program
}
