autoload -Uz compinit && compinit

if [ -f $HOME/.config/.zshrc-custom ]; then
	source $HOME/.config/.zshrc-custom >&2
fi

if [ -f $HOME/.config/aliases ]; then
        source $HOME/.config/aliases >&2
fi

alias vi=$(which nvim)
alias vim=/usr/bin/vi
alias edit-aliases="vi ~/.config/aliases; source ~/.config/aliases"

export PATH="$HOME/.local/bin:$PATH:/usr/local/go/bin"
export XDG_CONFIG_HOME="$HOME/.config"
export EDITOR=nvim

#eval "$(oh-my-posh init zsh --config $(brew --prefix oh-my-posh)/themes/catppuccin_frappe.omp.json)"
eval "$(oh-my-posh init zsh --config $HOME/.config/oh-my-posh.omp.json)"
