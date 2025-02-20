autoload -Uz compinit && compinit

if [ -f $HOME/.config/aliases ]; then
	source $HOME/.config/aliases >&2
fi

alias vim=/usr/bin/vi
alias edit-aliases="vi ~/.config/aliases; source ~/.config/aliases"

export PATH="$HOME/.local/bin:$PATH"
export XDG_CONFIG_HOME="$HOME/.config"
export EDITOR=nvim

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

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="/Users/mathijs/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)

# bun completions
[ -s "/Users/mathijs/.bun/_bun" ] && source "/Users/mathijs/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

