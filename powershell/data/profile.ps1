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


$PSDefaultParameterValues['Out-File:Encoding'] = 'utf8'
