#!/bin/sh

rm $HOME/.zshrc $HOME/.gitconfig

ln -s $HOME/.config/.zshrc $HOME/.zshrc
ln -s $HOME/.config/.gitconfig $HOME/.gitconfig
