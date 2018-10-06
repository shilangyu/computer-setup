$config = Get-Content config.json | ConvertFrom-Json

# global packages
foreach($pckg in $config.global) {
	npm i -g $pckg 
}
