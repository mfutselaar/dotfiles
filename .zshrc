alias xdebug="php -dxdebug.mode=debug -dxdebug.client_host=127.0.0.1 -dxdebug.client_port=9000 -dxdebug.start_with_request=yes "

autoload -Uz compinit && compinit

alias vim=/usr/bin/vi
alias vi=nvim
alias docker=podman

export PATH="/Users/mathijs/.dotnet/tools/:/Users/mathijs/.local/bin:$PATH"

export XDG_CONFIG_HOME="/Users/mathijs/.config"

#eval "$(oh-my-posh init zsh --config $(brew --prefix oh-my-posh)/themes/catppuccin_frappe.omp.json)"
eval "$(oh-my-posh init zsh --config $HOME/.config/oh-my-posh.omp.json)"

## Antidote plugins
#source $HOME/.local/share/antidote/antidote.zsh

#antidote load $HOME/.config/zsh_plugins.txt

emulator=${TERMINAL_EMULATOR:-default}

autoload colors; colors

if [ $emulator = "JetBrains-JediTerm" ]; then
	echo " $fg[white]Start podman: $fg[green]podman machine $fg[magenta]start$reset_color"
	echo "  $fg[white]Stop podman: $fg[green]podman machine $fg[magenta]stop$reset_color"
	echo "$fg[white]Podman status: $fg[green]podman $fg[magenta]info$reset_color"
else
	## Quote
	shuf -n 1 $HOME/.config/quotes.txt | fold -sw 70 | awk '{ print "\t" $0 }'
fi

echo ""

