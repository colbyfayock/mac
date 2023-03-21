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
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> "/Users/$(whoami)/.zprofile" 
eval "$(/opt/homebrew/bin/brew shellenv)"

# Packages
brew install --cask adobe-creative-cloud \
                    authy \
                    bartender \
                    deno \
                    discord \
                    dropbox \
                    figma \
                    firefox \
                    flux \
                    gh \
                    google-chrome \
                    iconset \
                    iterm2 \
                    mas \
                    nvm \
                    obs \ww
                    raycast \
                    rectangle \
                    switchresx \
                    tunnelbear \
                    visual-studio-code

# Configure nvm

mkdir ~/.nvm
. $(brew --prefix nvm)/nvm.sh
nvm install 14
nvm install 16
nvm install 18
nvm install 20
nvm alias default 18

# Add nvm autoload when navigatin to folder
echo "$(cat ./nvm/source.txt)\n\n$(cat ~/.zshrc)" > ~/.zshrc
echo "$(cat ~/.zshrc)\n\n$(cat ./nvm/autoload.txt)" > ~/.zshrc

# Install Yarn
npm install yarn -g

# Install Pnpm
curl -fsSL https://get.pnpm.io/install.sh | sh -

# App Store
mas install \
  937984704 \ # Amphetamine
  1487937127 \ # Craft
  498672703 \ # Droplr
  1480068668 \ # Messenger
  803453959 \ # Slack
  966085870 \ # TickTick
  1284863847 \ # Unsplash Wallpapers
  1147396723 \ # Whatsapp
  497799835 \ # Xcode

# Agree to Xcode license

sudo xcodebuild -license accept
  
# Configure git
cp ./git/.gitignore_global ~/
git config --global core.editor "nano"
git config --global core.excludesfile "~/.gitignore_global"
git config --global credential.helper osxkeychain; # activate git credentials storage
git config --global init.defaultBranch main
git config --global pull.rebase false
git config --global user.email "$GIT_EMAIL"
git config --global user.name "$GIT_NAME"

# Dev Environment

mkdir ~/Code
