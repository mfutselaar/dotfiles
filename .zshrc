if [ -f $HOME/.config/aliases ]; then
	source $HOME/.config/aliases >&2
fi

autoload -Uz compinit && compinit

alias vim=/usr/bin/vi
alias vi=nvim

export PATH="$HOME/.local/bin:$PATH"
export XDG_CONFIG_HOME="$HOME/.config"

#eval "$(oh-my-posh init zsh --config $(brew --prefix oh-my-posh)/themes/catppuccin_frappe.omp.json)"
eval "$(oh-my-posh init zsh --config $HOME/.config/oh-my-posh.omp.json)"

## Antidote plugins
#source $HOME/.local/share/antidote/antidote.zsh

#antidote load $HOME/.config/zsh_plugins.txt

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
		shuf -n 1 $HOME/.config/quotes.txt | fold -sw 70 | awk '{ print "\t" $0 }'
	fi

	echo ""
fi
