#!/bin/bash

cat > $devrc <<-EOF
source $SCRIPTS/pathmunge.sh;
source $SCRIPTS/filelimit.sh;

pathmunge "/usr/local/sbin";

alias ls='exa -G';
alias ll='exa -lh --git --modified --icons';
alias reload="source $shell_file";

alias subl="open -a 'Sublime Text.app'";
alias atom="open -a 'Atom.app'";
alias code="open -a 'Visual Studio Code.app'";

alias watch="npm run watch";
alias start="npm start";
alias test="npm run test";

alias pull="git pull";

EOF
