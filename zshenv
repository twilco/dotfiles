# env variables
export FZF_DEFAULT_COMMAND='fd --type file --follow'
export FZF_CTRL_T_COMMAND='fd --type file --follow'
export RISCV_OPENOCD_PATH="$HOME/usys/riscv/riscv-openocd-0.10.0-2019.02.0-x86_64-apple-darwin"
export RISCV_PATH="$HOME/usys/riscv/riscv64-unknown-elf-gcc-8.2.0-2019.02.0-x86_64-apple-darwin"

# random
# --------------------------------
alias mdkir='mkdir'
alias sg='sr google'
alias reloadshell='exec $SHELL -l'

# riscv
# --------------------------------
alias rvgcc='~/usys/riscv/riscv64-unknown-elf-gcc-8.2.0-2019.02.0-x86_64-apple-darwin/bin/riscv64-unknown-elf-gcc'
alias rvas='~/usys/riscv/riscv64-unknown-elf-gcc-8.2.0-2019.02.0-x86_64-apple-darwin/bin/riscv64-unknown-elf-as'
alias rvgdb='~/usys/riscv/riscv64-unknown-elf-gcc-8.2.0-2019.02.0-x86_64-apple-darwin/bin/riscv64-unknown-elf-gdb'
alias rvld='~/usys/riscv/riscv64-unknown-elf-gcc-8.2.0-2019.02.0-x86_64-apple-darwin/bin/riscv64-unknown-elf-ld'
alias rvqemu='qemu-system-riscv64'

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
alias gmff='git merge'
alias gm='git merge --no-ff'
alias gcoh='git checkout HEAD'
alias gslp='git stash && git pull && git stash pop'
# pushes branch upstream and then opens PR URL in browser
alias gprsup='open $(git push --set-upstream origin $(git_current_branch) 2>&1 | grep -Eo "(http|https)://[a-zA-Z0-9./?=_-]*")'

# docker
# --------------------------------
alias dc='docker-compose'
alias dcb='docker-compose build'
alias dcd='docker-compose down'
alias dcu='docker-compose up'
alias dcud='docker-compose up -d'
alias dcp='docker-compose pull'
alias dcrs='dcb && dcu'
alias dsta='docker stop $(docker ps -a -q)'
alias dps='docker ps'
alias dlo='docker logs'
alias dsh='dockersh'
function dockersh() {
  docker exec -it $1 /bin/bash
}

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
alias gcah='git checkout HEAD .idea/modules.xml && git checkout HEAD .idea/runConfigurations/* && git checkout HEAD .idea/vcs.xml && git checkout HEAD .idea/codeStyles/Project.xml && git checkout HEAD web/package-lock.json'
alias npmbd='cd web && npm run build-dev && cd ..'
alias fix-patterns='rm -r node_modules/npm'
alias dgir='./gradlew idea --refresh-dependencies && nvm use 6 && ./js.sh'
alias kdploy='function kdploy() { helm list | rg $1 | awk '{print $1}' | xargs helm delete --purge }'
### build all lannister lambdas 
alias lnba='./gradlew :lannister-lambda:accountworker:lambdaZip :lannister-lambda:billableaccounts:lambdaZip :lannister-lambda:integrationtest:lambdaZip'
### upload all lannister lambdas to S3
alias lnua='aws s3 cp ~/projects/lannister/lambda/accountworker/build/distributions/accountworker-LATEST.zip s3://widen-stage-lannister-lambdas --profile stage && aws s3 cp ~/projects/lannister/lambda/billableaccounts/build/distributions/billableaccounts-LATEST.zip s3://widen-stage-lannister-lambdas --profile stage && aws s3 cp ~/projects/lannister/lambda/integrationtest/build/distributions/integrationtest-LATEST.zip s3://widen-stage-lannister-lambdas --profile stage'
### publish lambda code stored in S3 to actual lambda function
alias lnpa='aws lambda update-function-code --function-name lannister-stage-billable-accounts-lambda --s3-bucket widen-stage-lannister-lambdas --s3-key billableaccounts-LATEST.zip --publish --profile stage && aws lambda update-function-code --function-name lannister-stage-account-worker-lambda --s3-bucket widen-stage-lannister-lambdas --s3-key accountworker-LATEST.zip --publish --profile stage && aws lambda update-function-code --function-name lannister-stage-integration-test-lambda --s3-bucket widen-stage-lannister-lambdas --s3-key integrationtest-LATEST.zip --publish --profile stage'
### build all lambdas, then upload them to S3, then publish the code to the actual lambda from S3
alias lnla='lnba && lambda/deploy-lambdas-stage-from-local.sh'

alias prod-lnua='aws s3 cp ~/projects/lannister/lambda/accountworker/build/distributions/accountworker-LATEST.zip s3://widen-prod-lannister-lambdas --profile prod && aws s3 cp ~/projects/lannister/lambda/billableaccounts/build/distributions/billableaccounts-LATEST.zip s3://widen-prod-lannister-lambdas --profile prod && aws s3 cp ~/projects/lannister/lambda/integrationtest/build/distributions/integrationtest-LATEST.zip s3://widen-prod-lannister-lambdas --profile prod'
alias prod-lnpa='aws lambda update-function-code --function-name lannister-prod-billable-accounts-lambda --s3-bucket widen-prod-lannister-lambdas --s3-key billableaccounts-LATEST.zip --publish --profile prod && aws lambda update-function-code --function-name lannister-prod-account-worker-lambda --s3-bucket widen-prod-lannister-lambdas --s3-key accountworker-LATEST.zip --publish --profile prod && aws lambda update-function-code --function-name lannister-prod-integration-test-lambda --s3-bucket widen-prod-lannister-lambdas --s3-key integrationtest-LATEST.zip --publish --profile prod'
alias prod-lnla='lnba && lambda/deploy-lambdas-prod-from-local.sh'

# elasticsearch
#---------------------------------
alias pull-es-docker='docker pull docker.elastic.co/elasticsearch/elasticsearch:5.5.2'
alias esdr='docker run -p 9200:9200 -e "http.host=0.0.0.0" -e "transport.host=127.0.0.1" docker.elastic.co/elasticsearch/elasticsearch:5.5.2'

# rust
#---------------------------------
alias cb='cargo build'
alias cck='cargo check'
alias cdo='cargo doc --open'
alias cfmt='cargo fmt'
alias cfb='cargo fmt && cargo build'
alias cfc='cargo fmt && cargo check'
alias cr='cargo run'
alias ct='cargo test'
alias twas='cargo test --target wasm32-unknown-unknown'

# tmux 
#---------------------------------
alias ta='tmux a'
alias tat='tmux a -t'
alias tn='tmux new'
alias tls='tmux ls'
alias tk='tmux kill-session -t'
alias tkall='tmux kill-server'

# vim/neovim
#---------------------------------
alias v='nvim'
