# stupid way of getting rid of the welcome message
Clear-Host

# starting directory
Set-Location ~/coding

# aliases
Remove-Item alias:gp -Force
Remove-Item alias:gc -Force
Remove-Item alias:gl -Force
Remove-Item alias:ls -Force
Remove-Item alias:cat -Force
Remove-Item alias:rm -Force
Remove-Item alias:echo -Force
function gp {	git push }
function gpl { git pull }
function gcl($githubPath) { git clone "https://github.com/$githubPath" }
function gs { git status }
function gc($commitMsg) { git commit -m $commitMsg }
function gl { git log }
function c { code . }
function nau { explorer . }
function vim($file) { nvim $file }
function ls($path) { lsd -a $path }
function la($path) { lsd -la $path }
function tb { nc termbin.com 9999 }
function o($item) { Invoke-Item $item }
function cat { bat @args }
function rm { coreutils rm @args }
function touch { coreutils touch @args }
function wc { coreutils wc @args }
function mkdir { coreutils mkdir -p @args }
function head { coreutils head @args }
function tail { coreutils tail @args }
function tee { coreutils tee @args }
function seq { coreutils seq @args }
function echo { coreutils echo @args }
	
# keybinds
Set-PSReadLineKeyHandler -Chord Alt+d -ScriptBlock {
	[Microsoft.PowerShell.PSConsoleReadLine]::Insert('$p = (fd -H --no-ignore --exclude node_modules --exclude .git --type d | fzf +m) ; if($p) { cd $p }')
	[Microsoft.PowerShell.PSConsoleReadLine]::AcceptLine()
}

# scriptlets
function serveo([Parameter(Mandatory = $true)]$customDomain, $port = "8080") {
	while ($true) {
		ssh -R "$($customDomain):80:$(ipv4):$port" serveo.net
		Start-Sleep 2
	}
}

function ipv4 {
	ipconfig | Where-Object { 
		$_ -match 'IPv4.+\s(\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3})' 
	} | Out-Null
	return $Matches[1]
}

function compress-vid($vid) {
	$file = New-Object System.IO.FileInfo($vid)
	ffmpeg -i $vid "$($file.BaseName)-compressed$($file.Extension)"
}

function vid-to-gif($vid) {
	$file = New-Object System.IO.FileInfo($vid)
	ffmpeg -i $vid -filter_complex 'fps=10,scale=320:-1:flags=lanczos,split [o1] [o2];[o1] palettegen [p]; [o2] fifo [o3];[o3] [p] paletteuse' "$($file.BaseName).gif"
}

function upgrade {
	sudo scoop update * -g
	sudo scoop cleanup -g *
	scoop cache rm *
	yarn global upgrade-interactive --latest
	cargo install @(cargo install --list | rg ' v\d.+:' -r `"`") 
	rustup update
}

# fish-like history search
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
Set-PSReadLineOption -HistorySearchCursorMovesToEnd 


$PSDefaultParameterValues['Out-File:Encoding'] = 'utf8'

# Invoke-Expression (&scoop-search --hook)

Invoke-Expression (& {
		$hook = if ($PSVersionTable.PSVersion.Major -lt 6) { 'prompt' } else { 'pwd' }
		(zoxide init --hook $hook powershell) -join "`n"
	})

Invoke-Expression (&starship init powershell)
