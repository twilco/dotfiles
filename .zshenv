# random
# --------------------------------
mdkir='mkdir'

# ls 
# --------------------------------
### Colorize the ls output
alias ls='ls -G'
### Use a long listing format
alias ll='ls -la'
### Show hidden files
alias l.='ls -Gd .*'

# cd 
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

# git 
# --------------------------------
### use hub wrapper over git commands
alias git='hub'
alias gmff='git merge'
alias gm='git merge --no-ff'

# docker 
# --------------------------------
alias dcd='docker-compose down'
alias dcu='docker-compose up -d'
alias dcp='docker-compose pull'
alias dcrs='dcd && dcp; dcu'

# ansible 
# --------------------------------
alias ag='ansible-galaxy -r install roles/requirements.yml --force'

# gradle 
# --------------------------------
alias gir='./gradlew idea --refresh-dependencies'
alias gi='./gradlew idea'

# widen 
# --------------------------------
alias wcom='~/scripts/print-widen-commit-syntax.sh'
