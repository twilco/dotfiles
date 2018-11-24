# random
# --------------------------------
alias mdkir='mkdir'

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
alias gcoh='git checkout HEAD'
alias gslp='git stash && git pull && git stash pop'

# docker
# --------------------------------
alias dc='docker-compose'
alias dcb='docker-compose build'
alias dcd='docker-compose down'
alias dcu='docker-compose up -d'
alias dcp='docker-compose pull'
alias dcrs='dcb && dcu'
alias dsta='docker stop $(docker ps -a -q)'

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
alias ct='cargo test'
alias cdo='cargo doc --open'
alias cr='cargo run'
alias twas='cargo test --target wasm32-unknown-unknown'
