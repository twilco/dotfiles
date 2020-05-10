#/bin/bash
set -e

sudo pacman -S yay
yay -S zsh
chsh -s $(which zsh)
read -p "Restart your computer now to make ZSH your main shell now (necessary to continue).  If you've already restarted, press anything to continue."

yay -S git meld

echo "Installing oh-my-zsh."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
echo "Installing zsh-autosuggestions."
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions

echo "Installing zsh-git-prompt -- TODO: replace this with https://github.com/woefe/git-prompt.zsh which doesn't use Python and is therefore probably faster"
git clone git@github.com:olivierverdier/zsh-git-prompt.git ~/.zsh/zsh-git-prompt
echo "Fixing zsh-git-prompt color -- make changed files appear as yellow rather than blue."
cp ~/projects/dotfiles/zsh-git-prompt-changed-files-yellow-instead-of-blue.patch ~/.zsh/zsh-git-prompt
cd ~/.zsh/zsh-git-prompt
git apply zsh-git-prompt-changed-files-yellow-instead-of-blue.patch
rm zsh-git-prompt-changed-files-yellow-instead-of-blue.patch
cd ~/projects/dotfiles

echo "Create an SSH key and upload it to your GitHub so your dotfiles can be cloned.  Press anything when complete."
echo "https://wiki.archlinux.org/index.php/SSH_keys"
read -p ""
git clone git@github.com:twilco/dotfiles.git ~/projects/dotfiles
echo "Removing existing ~/.zshrc that may have come pre-installed so we can symlink our own."
rm ~/.zshrc
cd ~/projects/dotfiles
./install
read -p "If any symlinks failed to be set up, fix them now (or remember to fix them later)."

yay -S nvm
echo 'source /usr/share/nvm/init-nvm.sh' >> ~/.zshrc
echo 'Reloading shell to make nvm available.'
exec $SHELL -l
nvm install stable

# Install this instead of vim because gvim comes with X support and the +clipboard feature enabled - https://wiki.archlinux.org/index.php/Vim#Installation
yay -S gvim

yay -S neovim 
pip install neovim
pip3 install neovim
echo "Setting nvim as default editor for git usage."
git config --global core.editor "nvim"

echo "Installing Mac fonts."
yay -S otf-san-francisco otf-san-francisco-pro otf-san-francisco-mono

echo "Installing freetype2-cleartype for better font rendering."
echo "https://wiki.archlinux.org/index.php/Font_configuration"
yay -S freetype2-cleartype

# Fixes Vim/Neovim startup bug.
sudo pip3 install --user pynvim

echo "Installing Rust."
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source $HOME/.cargo/env
rustup install stable nightly

echo "Installing Python 2 and 3."
sudo pacman -S python2 python3

yay -S gdb ripgrep xclip scrot

echo "Installing autojump."
git clone git://github.com/wting/autojump.git ~/projects/autojump
cd ~/projects/autojump
./install.py

echo "Creating non-version controlled ~/.zshenv-secret file for sensitive configuration."
touch ~/.zshenv-secret

echo "Installing Tmux plugin manager."
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

echo "Installing Proton VPN CLI client and its dependencies (openvpn dialog python-pip python-setuptools)"
sudo pacman -S openvpn dialog python-pip python-setuptools
sudo pip3 install protonvpn-cli
sudo protonvpn init

echo "Installing dependencies necessary to build WebKit (and other general systems-programming projects)."
yay -S apache-mod_bw ruby-json ruby-highline
sudo pacman -S cmake ccache gobject-introspection gperf ninja
ccache --max-size=8G

echo "Install via Pamac: xcape and xmodmap to turn caps lock into 'escape' if pressed alone, or 'control' if pressed with another key."
echo "Install via Pamac: tmux"
echo "https://github.com/alols/xcape"
echo 'xcape -e 'Control_L=Escape' -t 5' >> ~/.profile
echo ""

echo "In Firefox about:config -- Set 'browser.urlbar.clickSelectsAll' to true to select entire address bar on click."
echo "In Firefox about:config -- Set 'mousewheel.min_line_scroll_amount' to 60 to greatly increase scroll speed."
echo ""

echo "Open an instance of Neovim and type :PlugInstall to setup Vim plugins"
echo "Konsole theme: 'Linux Colors'"
echo "Enable 'Night Colors' redshifting."
echo ""

echo "You should increase max allowed inotify handles for better IDE performance in large projects."
echo "https://confluence.jetbrains.com/display/IDEADEV/Inotify+Watches+Limit"
echo "https://wiki.archlinux.org/index.php/Sysctl#Configuration"
echo "Add 'fs.inotify.max_user_watches = 524288' to a new '/etc/sysctl.d/99-sysctl.conf' file."
echo "Run 'sysctl -p /etc/sysctl.d/99-sysctl.conf'"
echo "You may also want to increase the heap size of your IDEs after installation."
echo ""

echo "Follow this guide to configure ProtonVPN to autoconnect at boot: https://github.com/ProtonVPN/linux-cli/blob/master/USAGE.md#via-systemd-service"
echo ""

echo "All done.  Restart your computer."
