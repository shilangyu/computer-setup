# global packages
$globalPackages = 'nodemon', 'create-react-app', 'http-server'
foreach($pckg in $globalPackages) {
	npm i -g $pckg 
}
