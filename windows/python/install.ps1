$config = Get-Content config.json | ConvertFrom-Json

# global packages
foreach($pckg in $config.global) {
	python -m pip install $pckg
}

# wheel files
Get-ChildItem .\data | ForEach-Object {
	python -m pip install ./data/$_
}
