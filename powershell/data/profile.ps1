function expl { 
	explorer . 
} 
function gclone($url) { 
	git clone https://github.com/$url 
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

New-Alias -Name "npm" pnpm
