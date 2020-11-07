#!/bin/fish

# relative to ~/.config
set config_backup \
    Code/User/ \
    fish/ \
    neofetch/ \
    typer-go/ \
    omnirun/ \
    starship.toml \
    tmux/ \
    alacritty/ \
    bottom/ \
    nvim/ \
    mpv/ \

cp ~/.config/$config_backup . -r --parents

# fix the previous copy
rm -r config
mv .$HOME/.config config
rm -r ./home

# relative to ~/.config
set config_cleanup \
    Code/User/globalStorage/ \
    Code/User/workspaceStorage/ \
    mpv/watch_later

rm config/$config_cleanup -r

# gnome config 
dconf dump / >gnome-config.ini
