export EDITOR=$(which nvim)
export GOPATH=~/.local/share/go
export PATH=$PATH:$GOPATH/bin
export GOBIN=$GOPATH/bin

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory
