fpath=("$HOME/.zsh/completions" $fpath)
autoload -Uz compinit && compinit

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

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
  local name="${1:-}"
  [[ "$name" == "." ]] && name=$(basename "$PWD")
  name=$(echo "$name" | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9._-]/_/g')
  [[ -z "$name" ]] && { tmux attach || tmux; return }

  tmux new-session -A -s "$name"
}

gac() {
        git add .
        if [ -n "$1" ]; then
                if [[ "$1" == "--amend" ]]; then
                        git commit --amend
                else
                        git commit -m "$1"
                fi
        else
                git commit
        fi
}

gact() {
        gac "$1"
        git tag -a "$2" -m "$2"
}

gacp() {
        gac "$1" "$2"
        git push 
}

gactp() {
        gact "$1" "$2"
        git push origin "$2"
}

alias gst="git stash push -u"

gtp() {
        if [ -n "$1" ]; then
                git tag -a "$1" -m "$1"
                git push
        else
                echo "You must provide a tag: gtp v1.0"
        fi
}

gpf() {
        if [ -n "$1" ]; then
                git push $1 -f
        else
                git push -f
        fi
}

export PATH="$HOME/.local/bin:$HOME/.local/share/npm/bin:/usr/local/go/bin:$HOME/.local/share/cargo/bin:$PATH"
export XDG_CONFIG_HOME="$HOME/.config"
export EDITOR=nvim

#eval "$(oh-my-posh init zsh --config $(brew --prefix oh-my-posh)/themes/catppuccin_frappe.omp.json)"
eval "$(oh-my-posh init zsh --config $HOME/.config/oh-my-posh.omp.json)"

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"


if [[ -f "$PYENV_ROOT/bin/pyenv" ]]; then
        eval "$(pyenv init - zsh)"
        eval "$(pyenv virtualenv-init -)"
fi


export HSA_OVERRIDE_GFX_VERSION=11.0.0
export ROCM_PATH=/opt/rocm

export DOTNET_CLI_TELEMETRY_OPTOUT=1
