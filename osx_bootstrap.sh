#!/usr/bin/env bash
# Bootstrap script for setting up a new OSX machine

# Ask for credentials and cache sudo access for 5 minutes
sudo -v

echo "Starting bootstrapping"

# Check for Homebrew, install if we don't have it
if test ! $(which brew); then
    echo "Installing homebrew..."
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

echo ""
echo "Updating homebrew recipes"
brew update

echo ""
echo "Installing GNU core utilities (those that come with OS X are outdated)"
brew install coreutils
brew install gnu-sed --with-default-names
brew install gnu-tar --with-default-names
brew install gnu-indent --with-default-names
brew install gnu-which --with-default-names

echo ""
echo "Installing GNU find, locate, updatedb, and xargs, g-prefixed"
brew install findutils

echo ""
echo "Installing Bash 4"
brew install bash

echo ""
echo "Installing zsh"
brew install zsh

if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo ""
    echo "Install oh-my-zsh"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

echo ""
echo "Changing default shell to zsh - will need to restart the computer for this to take effect"
chsh -s /bin/zsh

PACKAGES=(
    curl
    ffmpeg
    git
    hub
    libjpeg
    node
    npm
    python
    python3
    pypy
    ripgrep
    tmux
    tree
    vim
    wget
)

echo ""
echo "Installing packages..."
brew install ${PACKAGES[@]}

echo ""
echo "Cleaning up..."
brew cleanup

echo ""
echo "Installing cask..."
brew install caskroom/cask/brew-cask

CASKS=(
    alfred
    dropbox
    firefox
    flux
    google-chrome
    gpgtools
    iterm2
    java
    magicprefs
    slack
    spectacle
    spotify
    vagrant
    vagrant-manager
    visual-studio-code
    virtualbox
    vlc
)

echo ""
echo "Installing cask apps..."
brew cask install ${CASKS[@]}

echo ""
echo "Installing fonts..."
brew tap caskroom/fonts
FONTS=(
    font-inconsolata
    font-roboto
    font-clear-sans
)
brew cask install ${FONTS[@]}

echo ""
echo "Installing global npm packages..."
npm install git -g

echo ""
echo "Configuring OSX..."

echo ""
echo "Seting fast key repeat rate"
defaults write NSGlobalDomain KeyRepeat -int 0

echo ""
echo "Showing filename extensions by default"
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

echo ""
echo "Enabling tap-to-click"
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

echo ""
echo "Disabling 'natural' scroll"
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false

echo ""
echo "Disabling smart quotes and smart dashes as they're annoying when typing code"
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

echo ""
echo "Increasing sound quality for Bluetooth headphones/headsets"
defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" -int 40

echo ""
echo "Avoiding the creation of .DS_Store files on network volumes"
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

echo ""
echo "Showing status bar in Finder by default"
defaults write com.apple.finder ShowStatusBar -bool true

echo ""
echo "Enabling HiDPI display modes (requires restart)"
sudo defaults write /Library/Preferences/com.apple.windowserver DisplayResolutionEnabled -bool true

echo ""
echo "Linking config files..."
echo ""

echo ""
echo "Hard linking ./zshrc to ~/.zshrc"
ln -F ~/.zshrc .zshrc

echo ""
echo "Hard linking ./zshenv to ~/.zshenv"
ln -F ~/.zshenv .zshenv

echo ""
echo "Hard linking ./vscode/extensions.json to ~/.vscode/extensions.json"
mkdir -p ~/.vscode/ && touch ~/.vscode/extensions.json && ln -F ~/.vscode/extensions.json vscode/extensions.json

echo ""
echo "Hard linking ./vscode/settings.json to ~/Library/Application Support/Code/User/settings.json"
mkdir -p ~/Library/Application\ Support/Code/User/ && touch ~/Library/Application\ Support/Code/User/settings.json && ln -F ~/Library/Application\ Support/Code/User/settings.json vscode/settings.json

echo ""
echo "Hard linking ./htoprc to ~/.config/htop/htoprc"
mkdir -p ~/.config/htop/ && touch ~/.config/htop/htoprc && ln -F ~/.config/htop/htoprc htoprc

echo ""
echo "Hard linking ./.hyper.js to ~/.hyper.js"
touch ~/.hyper.js && ln -F ~/.hyper.js .hyper.js

echo "Bootstrapping complete"
echo "NOTE: You will still need to configure MagicPrefs via the GUI."