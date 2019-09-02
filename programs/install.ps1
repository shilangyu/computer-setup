# install scoop
Set-ExecutionPolicy Bypass -Scope Process -Force
Invoke-Expression (new-object net.webclient).downloadstring('https://get.scoop.sh')

$config = Get-Content config.json | ConvertFrom-Json

# add buckets
foreach ($bucket in $config.buckets) {
	scoop bucket add $bucket
}

# install programs
foreach ($program in $config.programs) {
	scoop install $program
}
