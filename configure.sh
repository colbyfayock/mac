#!/usr/bin/env bash

read -p "git name? " GIT_NAME
read -p "git email? " GIT_EMAIL

# Set some system configurations
defaults write com.apple.finder AppleShowAllFiles YES; # show hidden files
defaults write com.apple.dock autohide -bool true; # turn Dock auto-hidng on
defaults write NSGlobalDomain AppleShowAllExtensions -bool true; # show all file extensions
killall Dock 2>/dev/null;
killall Finder 2>/dev/null;

# install Xcode Command Line Tools
# https://github.com/timsutton/osx-vm-templates/blob/ce8df8a7468faa7c5312444ece1b977c1b2f77a4/scripts/xcode-cli-tools.sh
touch /tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress;
PROD=$(softwareupdate -l |
  grep "\*.*Command Line" |
  head -n 1 | awk -F"*" '{print $2}' |
  sed -e 's/^ *//' |
  tr -d '\n')
PROD=${PROD//"Label: "/}
softwareupdate -i "$PROD" --verbose;

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
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