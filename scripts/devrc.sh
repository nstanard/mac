#!/bin/bash

. ./functions.sh --source-only

cat > $devrc <<-EOF
source $SCRIPTS/pathmunge.sh
source $SCRIPTS/filelimit.sh

cd $DEV_FOLDER

# TODO: Figure out difference between zshell and bash prompting and split it out via scripts
GREEN=\$(tput setaf 65)
ORANGE=\$(tput setaf 166)
NORMAL=\$(tput sgr0)
export PS1="\${ORANGE}[%~] \${GREEN}%D{%f/%m/%y} %D{%L:%M:%S}\${NORMAL}: "
# export PS1="\${ORANGE}[%~] \${GREEN}\$(prompt_ruby_info)\${NORMAL}: "

export CLICOLOR=1;

export LSCOLORS=exfxcxdxbxegedabagacad;
export EXA_COLORS="da=1;34"

pathmunge "/usr/local/sbin"

# TODO: Put behind zshell specific check/step
touch ~/.hushlogin

touch ~/.envrc
source ~/.envrc

ftext ()
{
    grep -iIHrn --color=always "\$1" . | less -R -r
}

generateqr ()
{
    printf "\$@" | curl -F-=\<- qrenco.de
}

function col
{

  awk -v col=\$1 '{print \$col}'

}
alias c9="l | col 9"

function skip
{

    n=\$((\$1 + 1))

    cut -d' ' -f\$n-

}

mkcd () { mkdir -vp "\$@" && cd "\$@"; }

alias op1="/Applications/Google\ Chrome\ Canary.app/Contents/MacOS/Google\ Chrome\ Canary -incognito --auto-open-devtools-for-tabs $TEST_URL"

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
alias sloc="git ls-files \"*.js*\" \"*.scss\" | xargs wc -l";

alias cdev="cd ~/Development";

alias re="sudo !!";
alias RE="sudo !!";

alias h="history";
alias H="history";

alias c="clear";
alias C="clear";

alias l="exa -l --git --modified --icons";
alias ll="l -al"

alias aliasclear="unalias -a";

alias r="npm run \$1"

reload () {
    tmp=\$PWD;
    source ~/.devrc;
    cd \$tmp;
}
RELOAD () { reload };

alias subl="open -a 'Sublime Text.app'"
alias atom="open -a 'Atom.app'"
alias code="open -a 'Visual Studio Code.app'"

alias bl="brew services list"
alias bc="brew services cleanup"

# Terraform

alias tfstate="terraform state";
alias tfimport="terraform import";
alias tfinit="terraform init";
alias tfplan="terraform plan -no-color > tfplan.txt";
alias tfapply="terraform apply";
alias tfdestroy="terraform destroy";

# Git Aliases

get_branch_name() {
    if [ -d "./.git" ]; then
        branch_name="\$(git symbolic-ref -q HEAD)";
        branch_name="\${branch_name##refs/heads/}";
        branch_name="\${branch_name:-HEAD}";
    fi
}

alias gpop="git reset --soft HEAD~1"
alias push="git push origin HEAD"
alias ga='git add'
alias gaa='git add .'
alias gaaa='git add --all'
alias gau='git add --update'
alias gb='git branch'
alias gbd='git branch --delete '
alias gc='git commit'
alias gcm='get_branch_name && git commit --message "\$branch_name - \$msg"'
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
alias gl='git log'
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
function glf() { git log --all --grep="\$1"; }

# ----------------------
# SSH Agent Shortcuts (Sage)
# ----------------------

export SSH_SECRET_PATH="~/.ssh/gh";
alias sagegen="ssh-keygen -t ed25519 -f \$SSH_SECRET_PATH -C \"nstanard@gmail.com\""
alias sageeval="eval \"\$(ssh-agent -s)\""
alias sageauth="ssh-add --apple-use-keychain \$SSH_SECRET_PATH"
alias sagecopy="pbcopy < \$SSH_SECRET_PATH.pub"
alias sagelist="ssh-add -l"
alias sageclean="ssh-add -D"

# AUTOCOMPLETION

# initialize autocompletion
autoload -U compinit
compinit

# history setup
setopt APPEND_HISTORY
setopt SHARE_HISTORY
HISTFILE=$HOME/.zhistory
SAVEHIST=1000
HISTSIZE=999
setopt HIST_EXPIRE_DUPS_FIRST
setopt EXTENDED_HISTORY

# autocompletion using arrow keys (based on history)
if [[ hB == *i* ]]
then
    bind '"\e[A": history-search-backward'
    bind '"\e[B": history-search-forward'
fi
# GENERAL

# never beep
setopt NO_BEEP

# DOCKER - https://phoenixnap.com/kb/how-to-list-start-stop-docker-containers
alias di='docker images';
alias adi='docker images -a';

# AWS DOCKER

dauth() {
    ACCOUNT_ID=\$(aws sts get-caller-identity | jq -r ".Account");
    aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin "\$ACCOUNT_ID.dkr.ecr.us-east-1.amazonaws.com";
}
alias DAUTH=dauth;

dtag() {
    eval "\$(docker tag \$1\:latest \$2\:latest)";
}
alias DTAG=dtag;

dpush() {
    docker push \$1;
}
alias DPUSH=dpush;

# https://www.digitalocean.com/community/tutorials/how-to-remove-docker-images-containers-and-volumes
dprune () {
    docker system prune -a;
}
alias DPRUNE=dprune;

# NodeNV
pathmunge "$DEV_FOLDER/.nodenv/bin"
eval "\$(nodenv init -)"
nodenv shell 17.4.0

install_nodenv_update() {
    mkdir -p "\$(nodenv root)"/plugins
    git clone https://github.com/nodenv/nodenv-update.git "\$(nodenv root)"/plugins/nodenv-update
    nodenv update;
}

# The next line updates PATH for the Google Cloud SDK.
if [ -f "'\$UTILS_FOLDER'/google-cloud-sdk/path.zsh.inc" ]; then . "'\$UTILS_FOLDER'/google-cloud-sdk/path.zsh.inc"; fi
# The next line enables shell command completion for gcloud.
if [ -f "'\$UTILS_FOLDER'/google-cloud-sdk/completion.zsh.inc" ]; then . "'\$UTILS_FOLDER'/google-cloud-sdk/completion.zsh.inc"; fi

EOF
