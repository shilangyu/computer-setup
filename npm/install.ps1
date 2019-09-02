$config = Get-Content config.json | ConvertFrom-Json

# install pnpm first
npm i -g pnpm

# global packages
foreach ($pckg in $config.global) {
	pnpm i -g $pckg 
}
