#/bin/bash
set -e

sudo apt-get update -y
sudo apt-get install -y zsh
chsh -s $(which zsh)

sudo apt-get install -y meld curl

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

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
echo 'Reloading shell to make nvm available.'
exec $SHELL -l
nvm install stable

echo "Installing Python 2 and 3."
sudo apt-get install -y python2 python3

sudo apt-get install -y gnome-tweaks gnome-tweak-tool

sudo add-apt-repository universe
# Install pip2.
curl https://bootstrap.pypa.io/get-pip.py --output get-pip.py
sudo python2 get-pip.py

sudo apt-get install -y neovim python3-pip
pip install neovim
pip3 install neovim
echo "Setting nvim as default editor for git usage."
git config --global core.editor "nvim"

# Fixes Vim/Neovim startup bug.
sudo pip3 install --user pynvim

echo "Installing Rust."
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source $HOME/.cargo/env
rustup install stable nightly

sudo apt-get install -y valgrind gdb ripgrep xclip scrot libfreetype6 libfreetype6-dev

echo "Installing autojump."
git clone git://github.com/wting/autojump.git ~/projects/autojump
cd ~/projects/autojump
./install.py

echo "Creating non-version controlled ~/.zshenv-secret file for sensitive configuration."
touch ~/.zshenv-secret

echo "Installing Tmux plugin manager."
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

echo "Installing dependencies necessary to build WebKit (and other general systems-programming projects)."
sudo apt-get install -y ruby-json ruby-highline
sudo apt-get install -y cmake ccache gobject-introspection gperf ninja-build build-essential pkg-config libexpat-dev tmux
ccache --max-size=8G

echo "In Firefox about:config -- Set 'browser.urlbar.clickSelectsAll' to true to select entire address bar on click."
echo "In Firefox about:config -- Set 'mousewheel.min_line_scroll_amount' to 60 to greatly increase scroll speed."
echo ""

echo "Open an instance of Vim + Neovim and type :PlugInstall to setup plugins"
echo ""

sudo apt-get install -y redshift
echo "Configure Redshift."
echo ""

echo "You should increase max allowed inotify handles for better IDE performance in large projects."
echo "https://confluence.jetbrains.com/display/IDEADEV/Inotify+Watches+Limit"
echo "https://wiki.archlinux.org/index.php/Sysctl#Configuration"
echo "Add 'fs.inotify.max_user_watches = 524288' to a new '/etc/sysctl.d/99-sysctl.conf' file."
echo "Run 'sysctl -p /etc/sysctl.d/99-sysctl.conf'"
echo "You may also want to increase the heap size of your IDEs after installation."
echo ""

echo "Use gnome-tweak-tool to map capslock to control."
echo "All done.  Restart your computer."
