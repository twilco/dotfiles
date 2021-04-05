# If you come from bash you might have to change your $PATH.
export PATH="/usr/lib/ccache:$PATH"
export PATH="$PATH:/bin:/usr/bin"
export PATH="/usr/local/opt/mysql@5.6/bin:$PATH"

# For GTK+3
export PKG_CONFIG_PATH="/usr/local/opt/libffi/lib/pkgconfig"

# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh
export NO_HEADLESS=1

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME=""

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git autojump docker osx)
source $ZSH/oh-my-zsh.sh

### colored man pages
man() {
    env \
    LESS_TERMCAP_mb=$(printf "\e[1;31m") \
    LESS_TERMCAP_md=$(printf "\e[1;31m") \
    LESS_TERMCAP_me=$(printf "\e[0m") \
    LESS_TERMCAP_se=$(printf "\e[0m") \
    LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
    LESS_TERMCAP_ue=$(printf "\e[0m") \
    LESS_TERMCAP_us=$(printf "\e[1;32m") \
    man "$@"
}

source ~/projects/dotfiles/zsh-plugins/git-prompt/git-prompt.zsh
source ~/projects/dotfiles/zsh-plugins/git-prompt/customized-prompt.zsh
setopt prompt_subst
NEWLINE=$'\n'
PROMPT='%F{green}${NEWLINE}%D{%r} %f%F{yellow}%n%f $(gitprompt)%f%F{magenta}${NEWLINE}%~ %f%F{green}${NEWLINE}$%f '
RPROMPT=''

source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
# enable vi mode
# https://dougblack.io/words/zsh-vi-mode.html
bindkey -v

# reduce NORMAL <-> INSERT transition from 0.4 sec default to 0.1 sec
export KEYTIMEOUT=1

bindkey '^P' up-history
bindkey '^N' down-history
# shows interactive list of previous commands
bindkey '^r' history-incremental-search-backward

bindkey '^w' backward-kill-word

# makes backspace work after returning from NORMAL mode
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char

# ctrl + space to accept suggestion
bindkey '^ ' autosuggest-accept
# ctrl + enter to accept and execute suggestion - https://github.com/zsh-users/zsh-autosuggestions/issues/255
bindkey '^[[[CE  [[CE' autosuggest-execute
source ~/.zshenv
source ~/.zshenv-secret

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

autoload -U +X bashcompinit && bashcompinit

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

# added by travis gem
[ -f /Users/twilcock/.travis/travis.sh ] && source /Users/twilcock/.travis/travis.sh
export PATH="/usr/local/opt/ruby/bin:$PATH"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

source /usr/local/bin/functions 
