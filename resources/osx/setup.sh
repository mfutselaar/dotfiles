#!/bin/bash

# Check if Homebrew is installed; if not, install Homebrew
if ! command -v brew &> /dev/null; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Tap the homebrew/cask-fonts repository for fonts
brew tap homebrew/cask-fonts

# Install the packages using Homebrew
brew install htop
brew install tmux
brew install neovim
brew install ghostty
brew install aerospace
brew install node
brew install bun
brew install php
brew install xdebug
brew install mc
brew install --cask font-jetbrains-mono-nerd-font
brew install jandedobbeleer/oh-my-posh/oh-my-posh

echo "Installing .NET, this could take a while..."
curl -fsSL https://dot.net/v1/dotnet-install.sh | bash /dev/stdin --channel 8.0
curl -fsSL https://dot.net/v1/dotnet-install.sh | bash /dev/stdin --channel 9.0

~/.local/share/tmux/plugins/tpm/bin/install_plugins
