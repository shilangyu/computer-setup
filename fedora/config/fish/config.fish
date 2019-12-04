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
	# git
	abbr -g gp 'git push'
	abbr -g gpl 'git pull'
	abbr -g gcl 'git clone https://github.com/'
	abbr -g gs 'git status'
	abbr -g gc 'git commit -m'
	abbr -g gl 'git log'
	# dnf
	abbr -g dnf 'dnf -C'
	# code
	abbr -g c 'code .'
	# xclip
	abbr -g scb 'xclip -sel clip'
	abbr -g gcb 'xclip -o'
	abbr -g cbf 'xclip -selection clipboard -t image/png -o >'
	# unix commands
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

	set __d (pwd)
	cd ~
	mkdir backup

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
		cd $dir
		7z a ../backup/$dir.zip * -xr!$excluded
		cd ..
	end

	cd $__d
end

starship init fish | source
