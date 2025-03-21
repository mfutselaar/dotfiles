#!/bin/bash

path=$(pwd)
if [[ $path != */.config ]]; then
	echo "Please move the entirety of ${path} to ~/.config and run setup again."
	exit
fi

clear

if [ ! -d ~/.ssh ]; then
	mkdir ~/.ssh
	chmod 0700 ~/.ssh
fi

cat ~/.config/resources/generic/ssh/config >> ~/.ssh/config
cat ~/.config/resources/generic/ssh/authorized_keys >> ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys

git submodule update --init

git clone https://github.com/tmux-plugins/tpm ~/.local/share/tmux/plugins/tpm

./minimal-setup.sh

# Function to check the system type
check_system_type() {
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        ask_linux_type
    elif [[ "$OSTYPE" == "darwin"* ]]; then
    else
        echo "This script only supports Linux and macOS."
        exit 1
    fi
}

# Function to ask for Linux system type
ask_linux_type() {
    echo "####################################################################################"
    echo "##"
    echo "## Please enter the type of your Linux system:"
    echo "##   1. Desktop"
    echo "##   2. Server"
    echo "##"
    echo "####################################################################################"

    read -p "Enter the number corresponding to your choice: " choice

    case $choice in
        1)
            echo "You selected: Desktop"
            ~/.config/resources/linux/setup.sh false
            ;;
        2)
            echo "You selected: Server"
            ~/.config/resources/linux/setup.sh true
            ;;
        *)
            echo "Invalid choice. Please run the script again."
            ;;
    esac
}

# Start the script
check_system_type

git remote add upstream git@github.com:mfutselaar/dotfiles.git
