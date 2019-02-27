$config = Get-Content config.json | ConvertFrom-Json

# global packages
foreach($pckg in $config.global) {
	pnpm i -g $pckg 
}
