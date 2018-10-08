$sa =  New-Object -comobject shell.application
$Fonts =  $sa.NameSpace(0x14)

Get-ChildItem  ".\data\*.ttf" | ForEach-Object {
	$Fonts.CopyHere($_.FullName)
}
