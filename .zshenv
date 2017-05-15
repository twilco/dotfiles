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
### use hub wrapper over git commands
alias git='hub'

# DOCKER ALIASES
# --------------------------------
alias dcd='docker-compose down'
alias dcu='docker-compose up -d'
alias dcp='docker-compose pull'
alias dcrs='dcd && dcp; dcu'

# ANSIBLE ALIASES
# --------------------------------
alias ag='ansible-galaxy -r install roles/requirements.yml --force'