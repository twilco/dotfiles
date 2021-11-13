# env variables
export CCACHE_BASEDIR=/home/twilco/projects
export CHANGE_LOG_NAME="Tyler Wilcock"
export EDITOR=nvim
export EMAIL_ADDRESS="tyler_w@apple.com"
export RISCV_OPENOCD_PATH="$HOME/usys/riscv/riscv-openocd-0.10.0-2019.02.0-x86_64-apple-darwin"
export RISCV_PATH="$HOME/usys/riscv/riscv64-unknown-elf-gcc-8.2.0-2019.02.0-x86_64-apple-darwin"

# random
# --------------------------------
alias mdkir='mkdir'
alias sg='sr google'
alias reloadshell='exec $SHELL -l'

# fzf
# --------------------------------
alias vf='v -o $(fzf --height=70% --preview="bat {}" --preview-window=right:60%:wrap)'
# export fzf_preview_pane_opts='--height=70% --preview="bat {}" --preview-window=right:60%:wrap'
export FZF_DEFAULT_COMMAND='rg --files --follow'
export FZF_CTRL_T_COMMAND='$FZF_DEFAULT_COMMAND'

# riscv
# --------------------------------
alias rvgcc='~/usys/riscv/riscv64-unknown-elf-gcc-8.2.0-2019.02.0-x86_64-apple-darwin/bin/riscv64-unknown-elf-gcc'
alias rvas='~/usys/riscv/riscv64-unknown-elf-gcc-8.2.0-2019.02.0-x86_64-apple-darwin/bin/riscv64-unknown-elf-as'
alias rvgdb='~/usys/riscv/riscv64-unknown-elf-gcc-8.2.0-2019.02.0-x86_64-apple-darwin/bin/riscv64-unknown-elf-gdb'
alias rvld='~/usys/riscv/riscv64-unknown-elf-gcc-8.2.0-2019.02.0-x86_64-apple-darwin/bin/riscv64-unknown-elf-ld'
alias rvqemu='qemu-system-riscv64'
alias rvnm='~/usys/riscv/riscv64-unknown-elf-gcc-8.2.0-2019.02.0-x86_64-apple-darwin/bin/riscv64-unknown-elf-nm'

# ls
# --------------------------------
### Colorize the ls output
alias ls='ls -G --color'
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
# Most of these can probably be moved to the more standard ~/.gitconfig file.
alias gap='git add -p'
alias gcoh='git checkout HEAD'
alias gds='git diff --staged'
alias gmff='git merge'
alias gm='git merge --no-ff'
# Git show current branch
alias gscb='git branch --show-current'
alias grma='git rebase $(git_main_branch)'

# Pushes branch upstream and then opens PR in browser.
if [ "$(uname 2> /dev/null)" != "Linux" ]; then
    alias gprsup='open $(git push --set-upstream origin $(git branch --show-current) 2>&1 | grep -Eo "(http|https)://[a-zA-Z0-9./?=_-]*")'
else
    alias gprsup='firefox $(git push --set-upstream origin $(git branch --show-current) 2>&1 | grep -Eo "(http|https)://[a-zA-Z0-9./?=_-]*")'
fi


alias gslp='git stash && git pull && git stash pop'
alias grbc='git rebase --continue'

alias grbi='interactive_rebase_from_head'
function interactive_rebase_from_head() {
  git rebase -i HEAD~$1
}

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

# gradle
# --------------------------------
alias gir='./gradlew idea --refresh-dependencies'
alias gi='./gradlew idea'

# lldb
# --------------------------------
alias patp='lldb process attach -p'
alias patn='lldb process attach -n'

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

. "$HOME/.cargo/env"

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

# webkit
#---------------------------------
alias trw='trap-webprocess'
alias md="make debug"
alias mr="make release"
alias rwkt="run-webkit-tests --no-build --no-retry"
alias rwkta="run-webkit-tests --no-build --no-retry --accessibility-isolated-tree"
function run-all-webkit-test-configurations {
    echo "---------------- WebKit2 NO ISOLATED TREE ----------------"
    sleep 2
    rwkt $*

    echo "---------------- WebKit2 WITH ISOLATED TREE ----------------"
    sleep 2
    rwkta $*

    echo "---------------- WebKit1 NO ISOLATED TREE ----------------"
    sleep 2
    rwkt -1 $*
}
alias rwktall="run-all-webkit-test-configurations"
alias rcl="Tools/Scripts/resolve-ChangeLogs"
alias wkp="Tools/Scripts/webkit-patch"
