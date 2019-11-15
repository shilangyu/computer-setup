function fish_right_prompt
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
	abbr -g scb 'xclip -i'
	abbr -g gcb 'xclip -o'
	# unix commands
	abbr -g ls 'ls -a'
	abbr -g o 'xdg-open'
	abbr -g exe 'chmod +x'

	# starting directory
	cd ~/coding

	# aliases
	alias ls lsd
end

set fish_user_paths "$HOME/.local/bin" "$HOME/.yarn/bin" "$HOME/go/bin" "$HOME/.cargo/bin" $fish_user_paths

starship init fish | source
