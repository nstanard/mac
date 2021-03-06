#!/bin/bash

cat > $devrc <<-EOF
source $SCRIPTS/pathmunge.bash
source $SCRIPTS/filelimit.bash

pathmunge "/usr/local/sbin"

alias ls='exa -G'
alias ll='exa -lh --git --modified --icons'
alias reload="source $shell_file"

alias subl="open -a 'Sublime Text.app'"
alias atom="open -a 'Atom.app'"
alias code="open -a 'Visual Studio Code.app'"

EOF
