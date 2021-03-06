#!/bin/bash

touch ~/.bash-mac-profile

cat > ~/.bash-mac-profile <<-EOF
export NPM_TOKEN="$token"
export SP_REPOS=$SP_REPOS
export UTILS=$UTILS
export CONFIGS=$CONFIGS
export SCRIPTS=$SCRIPTS
export MYSQL_USER=$MYSQL_USER
export MYSQL_PASS=$MYSQL_PASS
export FLYWAY_PATH="$flyway_dir"
export JETTY_HOME="$jetty_dir"

source $SCRIPTS/pathmunge.bash
source $SCRIPTS/file-limit.bash

pathmunge "/usr/local/sbin"

alias ls='exa -G'
alias ll='exa -lh --git --modified --icons'
alias reload="source $shellfile"
alias subl="open -a 'Sublime Text.app'"
alias atom="open -a 'Atom.app'"
alias code="open -a 'Visual Studio Code.app'"
EOF
