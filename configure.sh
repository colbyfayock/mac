#!/usr/bin/env bash

read -p "git name? " GIT_NAME
read -p "git email? " GIT_EMAIL

# Set some system configurations
defaults write com.apple.finder AppleShowAllFiles YES; # show hidden files
defaults write com.apple.dock autohide -bool true; # turn Dock auto-hidng on
defaults write NSGlobalDomain AppleShowAllExtensions -bool true; # show all file extensions
killall Dock 2>/dev/null;
killall Finder 2>/dev/null;

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

echo "ZSH_DISABLE_COMPFIX=true\n\n$(cat ~/.zshrc)" > ~/.zshrc # https://github.com/ohmyzsh/ohmyzsh/issues/6835

# Copy oh-my-zsh settings
cp ./oh-my-zsh/aliases.zsh ~/.oh-my-zsh/custom

# Install Brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

# Install nvm
brew install nvm
mkdir ~/.nvm
. $(brew --prefix nvm)/nvm.sh
nvm install 12
nvm alias default 12

# Install Yarn
brew install yarn

# Add nvm autoload when navigatin to folder
echo "$(cat ./nvm/source.txt)\n\n$(cat ~/.zshrc)" > ~/.zshrc
echo "$(cat ~/.zshrc)\n\n$(cat ./nvm/autoload.txt)" > ~/.zshrc

# Configure git
cp ./git/.gitignore_global ~/
git config --global core.editor "nano"
git config --global user.email "$GIT_EMAIL"
git config --global user.name "$GIT_NAME"
git config --global core.excludesfile "~/.gitignore_global"
git config --global credential.helper osxkeychain; # activate git credentials storage
