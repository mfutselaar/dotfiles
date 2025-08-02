autoload -Uz compinit && compinit

bindkey -s '^[OH' '^[[H'  # home
bindkey -s '^[OF' '^[[F'  # end
bindkey -s '^[OA' '^[[A'  # up
bindkey -s '^[OB' '^[[B'  # down
bindkey -s '^[OD' '^[[D'  # left
bindkey -s '^[OC' '^[[C'  # right
bindkey '^?'      backward-delete-char          # bs         delete one char backward
bindkey '^[[3~'   delete-char                   # delete     delete one char forward
bindkey '^[[H'    beginning-of-line             # home       go to the beginning of line
bindkey '^[[F'    end-of-line                   # end        go to the end of line
bindkey '^[[1;5C' forward-word                  # ctrl+right go forward one word
bindkey '^[[1;5D' backward-word                 # ctrl+left  go backward one word
bindkey '^H'      backward-kill-word            # ctrl+bs    delete previous word
bindkey '^[[3;5~' kill-word                     # ctrl+del   delete next word

if [ -f $HOME/.config/.zshrc-custom ]; then
	source $HOME/.config/.zshrc-custom >&2
fi

if [ -f $HOME/.config/aliases ]; then
        source $HOME/.config/aliases >&2
fi

if command -v kind &> /dev/null
then
        source $HOME/.config/resources/kind
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

export HSA_OVERRIDE_GFX_VERSION=11.0.0
export ROCM_PATH=/opt/rocm
