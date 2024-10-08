function fish_greeting
    # intentionally left blank
end


function __fd
    set p (fd -H --no-ignore --exclude node_modules --exclude .git --type d 2> /dev/null | fzf +m)

    if test $p
        cd $p
        commandline -f repaint
    end
end


function fish_user_key_bindings
    bind \b backward-kill-path-component
    bind \e\[3\;5~ kill-word
    bind \ed __fd
    bind \eq 'cmatrix -s'
    bind \eb 'tmux new-window btm'
end

set -x XDG_DATA_HOME $HOME/.local/share
set -x XDG_CONFIG_HOME $HOME/.config
set -x XDG_STATE_HOME $HOME/.local/state
set -x XDG_CACHE_HOME $HOME/.cache

# fix rude apps adding stuff to my $HOME
set -x ANDROID_HOME $XDG_DATA_HOME/android
set -x CARGO_HOME $XDG_DATA_HOME/cargo
set -x RUSTUP_HOME $XDG_DATA_HOME/rustup
set -x JUPYTER_CONFIG_DIR $XDG_CONFIG_HOME/jupyter
set -x GEM_HOME $XDG_DATA_HOME/gem
set -x BUNDLE_USER_CONFIG $XDG_CONFIG_HOME/bundle
set -x BUNDLE_USER_CACHE $XDG_CACHE_HOME/bundle
set -x BUNDLE_USER_PLUGIN $XDG_DATA_HOME/bundle
set -x NUGET_PACKAGES $XDG_CACHE_HOME/NuGetPackages
set -x OPAMROOT $XDG_DATA_HOME/opam
set -x GRADLE_USER_HOME $XDG_DATA_HOME/gradle
set -x GOPATH $XDG_DATA_HOME/go
set -x DOCKER_CONFIG $XDG_CONFIG_HOME/docker
set -x JULIA_DEPOT_PATH $XDG_DATA_HOME/julia ""$JULIA_DEPOT_PATH
set -x IPYTHONDIR $XDG_CONFIG_HOME/ipython

set fish_user_paths "$HOME/.pub-cache/bin" "$HOME/.local/bin" "$GOPATH/bin" "$CARGO_HOME/bin" "$HOME/fvm/default/bin" $fish_user_paths

set -x TERM tmux-256color
set -x EDITOR nvim
set -x VISUAL code
set -x JULIA_NUM_THREADS (nproc)
set -x DOTNET_CLI_TELEMETRY_OPTOUT 1
set -x PIPENV_DONT_LOAD_ENV 1

if status --is-interactive
    # abbreviations
    abbr -g gp 'git push'
    abbr -g gpl 'git pull'
    abbr -g gcl --set-cursor 'git clone ssh://git@github.com/%'
    abbr -g gs 'git status'
    abbr -g gc --set-cursor 'git commit -m "%"'
    abbr -g gch 'git checkout'
    abbr -g gl 'git log --decorate --graph --oneline'

    abbr -g c 'code .'

    abbr -g scb 'xclip -sel clip'
    abbr -g gcb 'xclip -o'
    abbr -g fcb 'xclip -selection clipboard -t image/png -o >'

    abbr -g ls 'ls -A'
    abbr -g la 'ls -lAh'
    abbr -g o open
    abbr -g exe 'chmod +x'
    abbr -g mkdir 'mkdir -p'
    abbr -g mv 'mv -i'

    abbr -g tb 'nc termbin.com 9999 | xclip -sel clip'

    abbr -g dua 'dua -f binary'

    abbr -g fd 'fd -HI'

    abbr -g dl --set-cursor "yt-dlp '%'"

    abbr -g rsync 'rsync -Ph'

    abbr -g tokei 'tokei --num-format underscores'

    abbr -g croc 'croc --yes'

    # aliases
    alias ls lsd
    alias vim nvim
    alias cat bat

    # run tmux
    if not set -q TMUX
        # for some weird reason the config is reset on every startup? I need to load it manually each time
        tmux source-file ~/.config/tmux/tmux.conf
        exec tmux
    end
end


# scriptlets
function read_confirm --description "asks for [y/n]"
    while true
        read -l -P $argv[1]' [y/n] ' confirm

        switch $confirm
            case Y y
                return 0
            case N n
                return 1
        end
    end
end

function backup --description "backups all files to ~/backup"
    if test -d ~/backup
        if read_confirm 'backup folder exists, it will be removed before backing up. Ok?'
            rm -r ~/backup
        else
            return 1
        end
    end

    mkdir -p ~/backup/raw

    # relative to ~/
    set to_backup \
        wayback \
        coding \
        Music \
        Documents \
        games \
        Pictures

    set excluded \
        node_modules \
        .git \
        target \
        .dart_tool \
        rose

    for dir in $to_backup
        rsync -avr '--exclude=*/'$excluded'*' ~/$dir ~/backup/raw 1>/dev/null
        7z a ~/backup/$dir.7z ~/$dir/{*,.*} -xr!$excluded
    end
end

function serveo --description "exposes local network"
    while true
        ssh -R $argv[1]":80:"(ipv4)":"$argv[2] serveo.net
        sleep 1
    end
end


function upgrade --description "Full system upgrade. Linux package manager as well as language specific package managers."
    date -Iseconds >>~/.upgrade-timestamps.txt

    yay
    rustup update
    cargo install --list | rg ' v\\d.+:' -r '' | RUSTFLAGS='-C target-cpu=native' xargs cargo install
end

function file-parts
    string split -m1 -r . $argv[1]
end

function compress-vid
    set input (file-parts $argv[1])
    ffmpeg -i $argv[1] $input[1]-compressed.$input[2]
end

function compress-pdf
    set input (file-parts $argv[1])
    gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/prepress -dNOPAUSE -dQUIET -dBATCH -sOutputFile=$input[1]-compressed.pdf $input[1].pdf
end

function imgs-to-pdf --description "this works in place, will compress imgs"
    mogrify -auto-orient -strip -interlace Plane -gaussian-blur 0.05 -quality 85% $argv

    convert $argv out.pdf
end

function update-mirrors
    sudo cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak
    sudo reflector -f 12 -l 10 -n 12 --sort rate --save /etc/pacman.d/mirrorlist
end


zoxide init fish | source
starship init fish | source
