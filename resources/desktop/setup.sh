#!/bin/sh
rm ~/.zshrc ~/.gitconfig ~/.config/aliases ~/.config/.zshrc-custom 

ln -s ~/.config/resources/.zshrc ~/.zshrc
ln -s ~/.config/resources/.gitconfig ~/.gitconfig

ln -s ~/.config/resources/desktop/.zshrc ~/.config/.zshrc-custom
ln -s ~/.config/resources/desktop/aliases ~/.config/aliases

mkdir -p ~/.local/share/tmux/plugins
git clone https://github.com/tmux-plugins/tpm ~/.local/share/tmux/plugins/tpm
