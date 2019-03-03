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

echo "Installing Tmux plugin manager"
git clone "https://github.com/tmux-plugins/tpm" "~/.tmux/plugins/tpm"

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
echo "Installing cpuinfo - take action to add this to the MacOS top menubar"
brew cask install cpuinfo

echo ""
echo "Installing Bash 4"
brew install bash

echo ""
echo "Installing zsh"
brew install zsh

echo ""
echo "Clone zsh git prompt repo"
git clone https://github.com/twilco/zsh-git-prompt.git ~/.zsh/zsh-git-prompt

echo ""
echo "Clone zsh-autosuggestions repo"
git clone git://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions

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
    diff-so-fancy
    fd
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
    watch
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
    alacritty
    alfred
    dropbox
    firefox
    flux
    google-chrome
    gpgtools
    java
    magicprefs
    neovim
    ripgrep
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
echo "Showing hidden files in Finder by default"
defaults write com.apple.finder AppleShowAllFiles YES

echo ""
echo "Disable the “Are you sure you want to open this application?” dialog"
defaults write com.apple.LaunchServices LSQuarantine -bool false

echo ""
echo "Setting fast key repeat rate"
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
echo "Enabling text replacement on all apps"
defaults write -g WebAutomaticTextReplacementEnabled -bool true

#### Terminal

echo ""
echo "Only use UTF-8 in Terminal.app"
defaults write com.apple.terminal StringEncodings -array 4

#### Safari

echo ""
echo "Privacy: don’t send search queries to Apple"
defaults write com.apple.Safari UniversalSearchEnabled -bool false
defaults write com.apple.Safari SuppressSearchSuggestions -bool true

echo ""
echo "Enable Safari’s debug menu"
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true

echo ""
echo "Add a context menu item for showing the Web Inspector in web views"
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true

echo ""
echo "Remove useless icons from Safari’s bookmarks bar"
defaults write com.apple.Safari ProxiesInBookmarksBar "()"

echo ""
echo "Enable the Develop menu and the Web Inspector in Safari"
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true

echo ""
echo "Enable “Do Not Track”"
defaults write com.apple.Safari SendDoNotTrackHTTPHeader -bool true

echo ""
echo "Configuring git diff to use the 'diff-so-fancy' package for all git diff operations"
git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX"

echo ""
echo "Linking config files..."
echo ""

echo ""
echo "Hard linking ./zshrc to ~/.zshrc"
link ./.zshrc ~/.zshrc

echo ""
echo "Hard linking ./zshenv to ~/.zshenv"
link ./.zshenv ~/.zshenv

echo ""
echo "Hard linking ./vscode/extensions.json to ~/.vscode/extensions.json"
mkdir -p ~/.vscode/ && link ./vscode/extensions.json ~/.vscode/extensions.json

echo ""
echo "Hard linking ./vscode/settings.json to ~/Library/Application Support/Code/User/settings.json"
mkdir -p ~/Library/Application\ Support/Code/User/ && link ./vscode/settings.json ~/Library/Application\ Support/Code/User/settings.json

echo ""
echo "Hard linking ./htoprc to ~/.config/htop/htoprc"
mkdir -p ~/.config/htop/ && link ./htoprc ~/.config/htop/htoprc

echo ""
echo "Hard linking ./.hyper.js to ~/.hyper.js"
link ./.hyper.js ~/.hyper.js

echo "Bootstrapping complete"
echo "NOTE: You will still need to configure MagicPrefs via the GUI."
echo "NOTE: You will still need to install Meld, since that is what our .gitconfig uses as the difftool. http://meldmerge.org/"
echo "NOTE: You will still need to install the Hack font (assuming you still use it).  https://support.apple.com/en-us/HT201749 <- install instructions, https://sourcefoundry.org/hack/ <- font download
echo "NOTE: Review the entire output of this script to ensure no other action needs to be taken."
echo "Once you have taken all necessary actions, restart your computer to make the changes take effect."

