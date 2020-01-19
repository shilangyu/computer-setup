function fish_right_prompt
  # intentionally left blank
end

function fish_greeting
  # intentionally left blank
end

function fish_user_key_bindings
 	bind \b backward-kill-path-component
	bind \e\[3\;5~ kill-word
end	

if status --is-interactive
	# abbreviations
	abbr -g gp 'git push'
	abbr -g gpl 'git pull'
	abbr -g gcl 'git clone https://github.com/'
	abbr -g gs 'git status'
	abbr -g gc 'git commit -m'
	abbr -g gl 'git log'
	
	abbr -g dnf 'dnf -C'
	
	abbr -g c 'code .'
	
	abbr -g scb 'xclip -sel clip'
	abbr -g gcb 'xclip -o'
	abbr -g cbf 'xclip -selection clipboard -t image/png -o >'
	
	abbr -g nau 'nautilus .'

	abbr -g ls 'ls -a'
	abbr -g o 'xdg-open'
	abbr -g exe 'chmod +x'

	# starting directory
	cd ~/coding

	# aliases
	alias ls lsd
end

set fish_user_paths "$HOME/.local/bin" "$HOME/.npm-global/bin" "$HOME/go/bin" "$HOME/.cargo/bin" $fish_user_paths

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
	.git 
	
	for dir in $to_backup
		rsync -avr '--exclude=*/'$excluded'*' ~/$dir ~/backup/raw 1> /dev/null
		7z a ~/backup/$dir.zip ~/$dir/* -xr!$excluded
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


starship init fish | source
