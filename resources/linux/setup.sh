#!/bin/bash

if [ "$1" == "true" ]; then
    is_server_setup=true
else
    is_server_setup=false
fi

if [ ! -d "~/.sources" ]; then
    mkdir ~/.sources
fi

if command -v lsb_release > /dev/null; then
    DISTRO=$(lsb_release -si | tr '[:upper:]' '[:lower:]')
else
    echo "lsb_release command not found, unable to determine distribution."
    exit 1
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

has_docker=0

docker_installer() {
    if ask_yes_no "Do you want to proceed installing Docker?" "yes"; then        
        sudo apt-get -y install ca-certificates curl
        sudo install -m 0755 -d /etc/apt/keyrings
        sudo curl -fsSL https://download.docker.com/linux/$DISTRO/gpg -o /etc/apt/keyrings/docker.asc
        sudo chmod a+r /etc/apt/keyrings/docker.asc
        sudo groupadd docker
        sudo usermod -aG docker $USER

        echo \
          "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/$DISTRO \
          $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
          sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
        sudo apt-get -y update

        sudo apt-get -y install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

        has_docker=1
    fi
}

dotnet_installer() {
    if ask_yes_no "Do you want to proceed installing .NET Core 8.0 and 9.0?" "yes"; then
        sudo apt update -y
        sudo apt install -y apt-transport-https ca-certificates curl libc6 libgcc-s1 libgssapi-krb5-2 libicu72 liblttng-ust1 libssl3 libstdc++6 libunwind8 zlib1g

        echo "Downloading and executing dotnet-install.sh scripts, this could take a while..."
        wget https://dot.net/v1/dotnet-install.sh -O ~/.local/bin/dotnet-install.sh
        chmod +x ~/.local/bin/dotnet-install.sh


        if $is_server_setup; then
            ~/.local/bin/dotnet-install.sh --runtime aspnetcore --channel 8.0
            ~/.local/bin/dotnet-install.sh --runtime aspnetcore --channel 9.0
        else
            ~/.local/bin/dotnet-install.sh --channel 8.0
            ~/.local/bin/dotnet-install.sh --channel 9.0
        fi
    fi
}

podman_installer() {
    if ask_yes_no "Do you want to proceed installing podman?" "yes"; then
       sudo apt install -y podman
       pipx install podman-compose
       podman machine init
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

        # Install the PPA
        if [ "$DISTRO" = "debian" ]; then
            echo "deb http://packages.sury.org/php/ $(lsb_release -sc) main" | sudo tee /etc/apt/sources.list.d/php.list
            wget -qO - https://packages.sury.org/php/apt.gpg | sudo apt-key add -
        else
            sudo apt-add-repository -y ppa:ondrej/php
        fi

       sudo apt update

       if $is_server_setup; then
        sudo apt install -y php8.4-fpm php8.4-cli nginx
       else
        sudo apt install -y php8.4-cli php8-xdebug
       fi

       sudo apt install -y php8.4-common php8.4-{mysql,xml,gd,mbstring,zip,bcmath,curl,bz2,intl}
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

k8s_installer() {
    if ask_yes_no "Do you want to proceed installing k8s?" "no";  then
        sudo ./k8s.sh
        sudo kubeadm init
        mkdir -p ~/.kube
        sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
        sudo chown $(id -u):$(id -g) $HOME/.kube/config
        kubectl get pod -A
        kubectl apply -f https://github.com/weaveworks/weave/releases/download/v2.8.1/weave-daemonset-k8s.yaml
        kubectl get pods -A
        kubeadm token create — print-join-command > ~/KUBEADM_TOKEN.txt

        echo "#########################################################"
        echo "##"
        echo "## kube create output stored in ~/KUBEADM_TOKEN.txt"
        echo "##"
        echo "#########################################################"
    fi
}

sudo apt update -y
sudo apt install -y git zsh snapd mc curl htop python3 python3-pip pipx python3-launchpadlib tmux

~/.local/share/tmux/plugins/tpm/bin/install_plugins

mkdir -p ~/.local/bin
curl -s https://ohmyposh.dev/install.sh | bash -s -- -d ~/.local/bin

if $is_server_setup; then
    docker_installer
fi

if [ $has_docker == 0 ]; then
    k8s_installer
    podman_installer
fi

nerdfont_installer
dotnet_installer
node_installer
neovim_installer
php_installer

if [ ! $is_server_setup ]; then
    sudo snap install ghostty --classic
fi

sudo apt autoremove

chsh -s $(which zsh)
