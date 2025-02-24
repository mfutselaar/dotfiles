autoload -Uz compinit && compinit

if [ -f $HOME/.config/.zshrc-custom ]; then
	source $HOME/.config/.zshrc-custom >&2
fi

if [ -f $HOME/.config/aliases ]; then
        source $HOME/.config/aliases >&2
fi

if command -v kind &> /dev/null
then
        source $HOME/.config/resources/generic/kind
fi

alias vi=$(which nvim)
alias vim=/usr/bin/vi
alias edit-aliases="vi ~/.config/aliases; source ~/.config/aliases"

tmu() {
  if [ -n "$1" ]; then
    tmux attach-session -t "$1" || tmux new-session -s "$1"
  else
    tmux attach-session || tmux new-session
  fi
}

gac() {
        git add .
        if [ -n "$1" ]; then
                if [[ "$1" == "--amend" ]]; then
                        git commit --amend
                else
                        git commit -m "$@"
                fi
        else
                git commit
        fi
}

gacp() {
        gac $@
        git push
}

export PATH="$HOME/.local/bin:$PATH:/usr/local/go/bin"
export XDG_CONFIG_HOME="$HOME/.config"
export EDITOR=nvim

#eval "$(oh-my-posh init zsh --config $(brew --prefix oh-my-posh)/themes/catppuccin_frappe.omp.json)"
eval "$(oh-my-posh init zsh --config $HOME/.config/oh-my-posh.omp.json)"

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="/Users/mathijs/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)
