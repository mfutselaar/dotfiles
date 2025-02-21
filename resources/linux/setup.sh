#!/bin/bash

if [ "$1" == "true" ]; then
    is_server_setup=true
else
    is_server_setup=false
fi

if [ ! -d "~/.sources" ]; then
    mkdir ~/.sources
fi

# Function for yes/no prompt
ask_yes_no() {
    local prompt_message=$1
    local default_answer=$2
    local answer

    echo ""
    echo "##############################################"
    echo ""

    if [ "$default_answer" == "yes" ]; then
        read -p "$prompt_message [Y/n]: " answer
        answer=${answer:-yes}
    else
        read -p "$prompt_message [y/N]: " answer
        answer=${answer:-no}
    fi

    if [[ "$answer" =~ ^[Yy][Ee]?[Ss]?$ ]]; then
        return 0  # true
    else
        return 1  # false
    fi
}

docker_installer() {
    if ask_yes_no "Do you want to proceed installing Docker?" "yes"; then        
        sudo apt-get -y install ca-certificates curl
        sudo install -m 0755 -d /etc/apt/keyrings
        sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
        sudo chmod a+r /etc/apt/keyrings/docker.asc
        sudo groupadd docker
        sudo usermod -aG docker $USER

        echo \
          "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
          $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
          sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
        sudo apt-get -y update

        sudo apt-get -y install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
    fi
}

podman_installer() {
    if ask_yes_no "Do you want to proceed installing podman?" "yes"; then
       sudo apt install -y podman
       pipx install podman-compose
    fi
}

node_installer() {
    if ask_yes_no "Do you want to proceed installing NodeJS?" "yes"; then
        sudo apt install nodejs npm
        npm config set prefix ~/.local/npm
        curl -fsSL https://bun.sh/install | bash
    fi
}

php_installer() {
    if ask_yes_no "Do you want to proceed installing PHP?" "yes"; then
       sudo apt install -y software-properties-common gnupg2  apt-transport-https lsb-release ca-certificates
       sudo add-apt-repository -y ppa:ondrej/php

       if $is_server_setup; then
        sudo apt install -y php8.4-fpm php8.4-cli nginx
       else
        sudo apt install -y php8.4-cli php8-xdebug
       fi

       sudo apt install -y php8.4-common php8.4-mysql php8.4-xml php8.4-gd php8.4-mbstring php8.4-zip php8.4-bcmath php8.4-curl
    fi
}

neovim_installer() {
    if ask_yes_no "Do you want to proceed installing NeoVim?" "yes"; then
        git clone https://github.com/neovim/neovim.git ~/.sources/neovim
        sudo apt install -y cmake gettext lua5.1 liblua5.1-0-dev
        git -C ~/.sources/neovim fetch --all
        git -C ~/.sources/neovim checkout v0.10.2
        make -C ~/.sources/neovim clean
        make -C ~/.sources/neovim CMAKE_BUILD_TYPE=RelWithDebInfo
        sudo make -C ~/.sources/neovim install
    fi
}

nerdfont_installer() {
    if ask_yes_no "Do you want to proceed installing a nerdfont??" "yes"; then
        wget -O ~/JetBrainsMono.zip https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/JetBrainsMono.zip
        mkdir -p ~/.local/share/fonts
        unzip ~/JetBrainsMono.zip -d ~/.local/share/fonts
        rm ~/JetBrainsMono.zip
        sudo apt install -y fontconfig
        fc-cache -fv
    fi
}

sudo apt update -y
sudo apt install -y git zsh snapd mc curl htop python3 python3-pip pipx python3-launchpadlib
sudo snap install tmux --classic

~/.local/share/tmux/plugins/tpm/bin/install_plugins

mkdir -p ~/.local/bin
curl -s https://ohmyposh.dev/install.sh | bash -s -- -d ~/.local/bin

if $is_server_setup; then
    docker_installer
else
    nerdfont_installer
    podman_installer
    sudo snap install ghostty --classic
fi

node_installer
neovim_installer
php_installer

sudo apt autoremove

chsh -s $(which zsh)
