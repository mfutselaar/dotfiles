autoload -Uz compinit && compinit

emulator=${TERMINAL_EMULATOR:-default}
host=$(hostname)

autoload colors; colors

if [ $host = "Lagertha" ]; then
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

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="$HOME/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
