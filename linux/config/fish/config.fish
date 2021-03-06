function fish_right_prompt
    # intentionally left blank
end

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
    bind \eq cmatrix\ -s
    bind \eb tmux\ new-window\ btm
end


if status --is-interactive
    # abbreviations
    abbr -g gp 'git push'
    abbr -g gpl 'git pull'
    abbr -g gcl 'git clone ssh://git@github.com/'
    abbr -g gs 'git status'
    abbr -g gc 'git commit -m'
    abbr -g gl 'git log'
    abbr -g gct 'git ls-files | grep -Ev "yarn.lock" | xargs wc -l'

    abbr -g dnf 'dnf -C'

    abbr -g c 'code .'

    abbr -g scb 'xclip -sel clip'
    abbr -g gcb 'xclip -o'
    abbr -g fcb 'xclip -selection clipboard -t image/png -o >'

    abbr -g nau 'nautilus .'

    abbr -g ls 'ls -a'
    abbr -g o 'open'
    abbr -g exe 'chmod +x'
    abbr -g mkdir 'mkdir -p'

    abbr -g tb 'nc termbin.com 9999 | xclip -sel clip'

    abbr -g dua 'dua -f binary'

    abbr -g dl 'youtube-dl -f="bestvideo[height<1601]+bestaudio"'

    abbr -g rsync 'rsync -Ph'

    # aliases
    alias ls lsd
    alias vim nvim
    alias cat bat
    alias grep rg

    # starting directory
    cd ~/coding

    # run tmux
    if not set -q TMUX
        # for some weird reason the config is reset on every startup? I need to load it manually each time
        tmux source-file ~/.config/tmux/tmux.conf
        exec tmux
    end
end

set fish_user_paths "$HOME/.pub-cache/bin" "$HOME/.local/bin" "$HOME/.yarn/bin" "$HOME/go/bin" "$HOME/.cargo/bin" $fish_user_paths

set -x EDITOR nvim
set -x VISUAL code
set -x TERM alacritty
set -x JULIA_NUM_THREADS (nproc)


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
        rose

    for dir in $to_backup
        rsync -avr '--exclude=*/'$excluded'*' ~/$dir ~/backup/raw 1>/dev/null
        7z a ~/backup/$dir.7z ~/$dir/* -xr!$excluded
    end
end

function ipv4 --description "returns your private ip"
    echo (hostname -I | awk '{print $1}')
end

function serveo --description "exposes local network"
    while true
        ssh -R $argv[1]":80:"(ipv4)":"$argv[2] serveo.net
        sleep 1
    end
end

function ts_node
    set dir temp(random)
    if tsc --outDir $dir
        node $dir/$argv[1]
    end
    rm -rf $dir
end

function upgrade
    set yes false
    if test $argv[1] = '-y' 2>/dev/null
        set yes true
    end

    if $yes
        sudo dnf upgrade -y
        flatpak update -y
        yarn global upgrade --latest
    else
        yay
        yarn global upgrade-interactive --latest
    end

    cargo install --list | grep ' v\\d.+:' -r '' | xargs cargo install
    rustup update
end

function fix-touchpad
    sudo rmmod rmi_smbus
    sudo modprobe rmi_smbus
end

function yarn-restart
    rm -rf node_modules && yarn
end

function file-parts
    string split -m1 -r . $argv[1]
end

function compress-vid
    set input (file-parts $argv[1])
    ffmpeg -i $argv[1] $input[1]-compressed.$input[2]
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
