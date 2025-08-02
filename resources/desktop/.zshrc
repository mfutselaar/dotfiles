autoload -Uz compinit && compinit

export GOPATH=~/.local/share/go
export GOBIN=$GOPATH/bin

emulator=${TERMINAL_EMULATOR:-default}

autoload colors; colors

if [[ "$OSTYPE" == "darwin"  ]]; then
	if [ $emulator = "JetBrains-JediTerm" ]; then
		echo " $fg[white]Start podman: $fg[green]podman machine $fg[magenta]start$reset_color"
		echo "  $fg[white]Stop podman: $fg[green]podman machine $fg[magenta]stop$reset_color"
		echo "$fg[white]Podman status: $fg[green]podman $fg[magenta]info$reset_color"
	else
		## Quote
		shuf -n 1 $HOME/.config/resources/osx/quotes.txt | fold -sw 70 | awk '{ print "\t" $0 }'
	fi

	echo ""
fi

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH:$GOPATH/bin"

export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
