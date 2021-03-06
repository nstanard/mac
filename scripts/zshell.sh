#!/bin/bash

if [ -z "$CI" ] && no_zsh_frameworks && no_prompt_customizations_in_shell_file; then
    if ! grep -qs "prompt_ruby_info()" "$shell_file"; then
      cat <<EOT >> "$shell_file"

  prompt_ruby_info() {
    echo $(ruby -v | grep -o 'ruby [^\( ]*')
  }
EOT
    fi
    # shellcheck disable=SC2016
    append_to_file "$shell_file" 'GREEN=$(tput setaf 65)'
    # shellcheck disable=SC2016
    append_to_file "$shell_file" 'ORANGE=$(tput setaf 166)'
    # shellcheck disable=SC2016
    append_to_file "$shell_file" 'NORMAL=$(tput sgr0)'
    # display pwd in orange, current ruby version in green,
    # and set prompt character to $
    # shellcheck disable=SC2016
    if [ "$shell_file" = "$HOME/.profile" ]; then
      append_to_file "$shell_file" 'export PS1="${ORANGE}[\w] ${GREEN}$(prompt_ruby_info) ${NORMAL}$ "'
    else
      append_to_file "$shell_file" 'precmd () { PS1="${ORANGE}[%~] ${GREEN}$(prompt_ruby_info) ${NORMAL}$ " }'
    fi
    # display directories and files in different colors when running ls
    append_to_file "$shell_file" 'export CLICOLOR=1;'
    append_to_file "$shell_file" 'export LSCOLORS=exfxcxdxbxegedabagacad;'
fi
