#!/bin/fish

set config_backup \
Code/User/ \
fish/ \
neofetch/ \
typer-go/ \
omnirun/ \
starship.toml \

for dir in $config_backup
	cp ~/.config/$dir . -r --parents
end

rm -r config
mv .$HOME/.config config
rm -r ./home

set config_cleanup \
Code/User/globalStorage/ \
Code/User/workspaceStorage/ \

for dir in $config_cleanup
	rm config/$dir -r
end

rm -r other_config
mkdir other_config
guake --save-preferences other_config/guake.conf
