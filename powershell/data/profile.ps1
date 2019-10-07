function expl { 
	explorer . 
} 
function npmtemp() {
	$newdir = "temp-$(randstr(5))"
	New-Item -ItemType "directory" $newdir 
	Set-Location $newdir
	New-Item index.js
	pnpm init -y
	$packages = $args -Split "`n" 
	foreach ($package in $packages) {
		pnpm i $package
	}
}

function serveo([Parameter(Mandatory = $true)]$customDomain, $port = "8080") {
	while ($true) {
		ssh -R "$($customDomain):80:$(ipv4):$port" serveo.net
		sleep 2
	}
}

function ipv4 {
	ipconfig | Where-Object { 
		$_ -match 'IPv4.+\s(\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3})' 
	} | Out-Null
return $Matches[1]
}

function randstr($length) {
	return -join ((65..90) + (97..122) | Get-Random -Count $length | ForEach-Object { [char]$_ })
}

function g:c() {
	git commit -m "$($args -Join ' ')"
}
function g:cl($url) { 
	git clone https://github.com/$url 
}
function g:s() {
	git status
}

function g:l() {
	git log
}

function g:p() {
	git push
}


New-Alias -Name "npm" pnpm
New-Alias -Name "npx" pnpx

function which($cmd) {
	return Get-Command $cmd | Select-Object Name, Path
}

function compress-mp4($vid) {
	ffmpeg -i $vid -vcodec h264 -acodec aac compressed.mp4
}


$PSDefaultParameterValues['Out-File:Encoding'] = 'utf8'
