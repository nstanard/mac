#!/bin/bash

. ./functions.sh --source-only

cat > $devrc <<-EOF
source $SCRIPTS/pathmunge.sh
source $SCRIPTS/filelimit.sh

pathmunge "/usr/local/sbin"

alias learn="open -a /Applications/Google\ Chrome.app https://www.udemy.com/home/my-courses/learning/"

# my main repo list shortcut
alias repols="open -a /Applications/Google\ Chrome.app https://github.com/stars/nstanard/lists/repositories/"

# bash cheat sheet shortcut
alias bs="open -a /Applications/Google\ Chrome.app https://devhints.io/bash"

# list aliases
alias commands="grep -in --color -e '^alias\s+*' ~/.devrc | sed 's/alias //' | grep --color -e ':[a-z][a-z0-9]*'"

# keep mac alive for a certain time
alias nosleep=caffeinate -distu 360000

# count lines of code quickly
alias sloc="git ls-files \"*.js*\" \"*.scss\" | xargs wc -l"

alias re='sudo !!'

alias h='history'

alias c='clear'

alias ls='exa -lh --git --modified --icons'
alias lss='ls -lahF'

alias reload="unalias -a && source ~/.devrc"

alias subl="open -a 'Sublime Text.app'"
alias atom="open -a 'Atom.app'"
alias code="open -a 'Visual Studio Code.app'"

alias watch="npm run watch"
alias start="npm start"
alias test="npm run test"
alias lint="npm run lint"

# GIT
# ----------------------
# Git Aliases
# ----------------------
alias push="git push origin HEAD"

alias ga='git add'
alias gaa='git add .'
alias gaaa='git add --all'
alias gau='git add --update'
alias gb='git branch'
alias gbd='git branch --delete '
alias gc='git commit'
alias gcm='git commit --message'
alias gcf='git commit --fixup'
alias gco='git checkout'
alias gcob='git checkout -b'
alias gcom='git checkout master'
alias gcos='git checkout staging'
alias gcod='git checkout develop'
alias gd='git diff'
alias gda='git diff HEAD'
alias gf='git fetch --all'
alias gi='git init'
alias glg='git log --graph --oneline --decorate --all'
alias gld='git log --pretty=format:"%h %ad %s" --date=short --all'
alias gm='git merge --no-ff'
alias gma='git merge --abort'
alias gmc='git merge --continue'
alias gp='git pull'
alias gpr='git pull --rebase'
alias gr='git rebase'
alias gs='git status'
alias gss='git status --short'
alias gst='git stash'
alias gsta='git stash apply'
alias gstd='git stash drop'
alias gstl='git stash list'
alias gstp='git stash pop'
alias gsts='git stash save'

# ----------------------
# Git Functions
# ----------------------
# Git log find by commit message
function glf() { git log --all --grep="$1"; }

# ----------------------
# SSH Agent Shortcuts (Sage)
# ----------------------

export SSH_SECRET_PATH="~/.ssh/gh";
alias sagegen="ssh-keygen -t ed25519 -f $SSH_SECRET_PATH -C \"nstanard@gmail.com\""
alias sageeval="eval \"\$(ssh-agent -s)\""
alias sageauth="ssh-add -K $SSH_SECRET_PATH"
alias sagecopy="pbcopy < $SSH_SECRET_PATH.pub"
alias sagelist="ssh-add -l"
alias sageclean="ssh-add -D"

if [[ $- == *i* ]]
then
    bind '"\e[A": history-search-backward'
    bind '"\e[B": history-search-forward'
fi

# DOCKER - https://phoenixnap.com/kb/how-to-list-start-stop-docker-containers
alias di='docker images'
alias adi='docker images -a'

# NodeNV
pathmunge "~/Development/.nodenv/bin"
eval "\$(nodenv init -)"
nodenv shell 17.4.0

install_nodenv_update() {
    mkdir -p "$(nodenv root)"/plugins
    git clone https://github.com/nodenv/nodenv-update.git "$(nodenv root)"/plugins/nodenv-update
    nodenv update;
}

alias r="npm run $1"

# The next line updates PATH for the Google Cloud SDK.
if [ -f "'$UTILS_FOLDER'/google-cloud-sdk/path.zsh.inc" ]; then . "'$UTILS_FOLDER'/google-cloud-sdk/path.zsh.inc"; fi
# The next line enables shell command completion for gcloud.
if [ -f "'$UTILS_FOLDER'/google-cloud-sdk/completion.zsh.inc" ]; then . "'$UTILS_FOLDER'/google-cloud-sdk/completion.zsh.inc"; fi
EOF
