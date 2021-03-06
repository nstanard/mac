#!/bin/bash

. ./functions.sh --source-only

cat > $devrc <<-EOF
source $SCRIPTS/pathmunge.sh
source $SCRIPTS/filelimit.sh

pathmunge "/usr/local/sbin"

alias cll='ls -lahF'

alias ls='exa -G'
alias ll='exa -lh --git --modified --icons'

alias reload="source ~/.devrc"

alias subl="open -a 'Sublime Text.app'"
alias atom="open -a 'Atom.app'"
alias code="open -a 'Visual Studio Code.app'"

alias watch="npm run watch"
alias start="npm start"
alias test="npm run test"

nodenv shell 14.15.5

EOF
