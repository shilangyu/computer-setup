# wheel files
Get-ChildItem .\data | ForEach-Object {
	python -m pip install ./data/$_
}
