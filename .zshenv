source ~/.zshrc
# ls ALIASES
# --------------------------------
### Colorize the ls output
alias ls='ls -G'
### Use a long listing format
alias ll='ls -la'
### Show hidden files
alias l.='ls -Gd .*'

# cd ALIASES
# --------------------------------
### back 1 directory 
alias ..='cd ..'
alias .1='cd ..'
### cd back 2  directories
alias .2='cd ../../'
alias ...='cd ../../' 
### back 3 directories
alias .3='cd ../../../'
alias ....='cd ../../../'
### back 4 directories 
alias .....='cd ../../../../' 
alias .4='cd ../../../../' 

# GIT ALIASES
# --------------------------------
alias gs='git status'
alias gp='git push'
alias gpu='git pull'
alias gcl='git clone'
alias gb='git branch'
alias gd='git diff'
alias gc='git commit -m'
alias ga='git add -A'
### git commit all unstaged files with a message 
alias gca='git commit -am'
### use hub wrapper over git commands
alias git='hub'

# DOCKER ALIASES
# --------------------------------
alias dcd='docker-compose down'
alias dcu='docker-compose up -d'
alias dcp='docker-compose pull'
alias dcrs='dcd && dcp; dcu'