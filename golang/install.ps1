$config = Get-Content config.json | ConvertFrom-Json

# packages
foreach($pckg in $config.packages) {
	go get $pckg 
}
