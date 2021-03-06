#!/bin/bash

append_to_file "$shell_file" 'export PATH="$HOME/.bin:$PATH"'

# shellcheck disable=SC2154
trap 'ret=$?; test $ret -ne 0 && printf "failed\n\n" >&2; exit $ret' EXIT

set -e

if [ ! -d "$HOME/.bin/" ]; then
  mkdir "$HOME/.bin"
fi

case "$SHELL" in
  */zsh) :
    create_zshrc_and_set_it_as_shell_file
    ;;
  *)
    create_profile_and_set_it_as_shell_file
    if [ -z "$CI" ]; then
      bold=$(tput bold)
      normal=$(tput sgr0)
      echo "Want to switch your shell from the default ${bold}bash${normal} to ${bold}zsh${normal}?"
      echo "Both work fine for development, and ${bold}zsh${normal} has some extra "
      echo "features for customization and tab completion."
      echo "If you aren't sure or don't care, we recommend ${bold}zsh${normal}."
      echo -n "Press ${bold}y${normal} to switch to zsh, ${bold}n${normal} to keep bash: "
      read -r -n 1 response
      if [ "$response" = "y" ]; then
        fancy_echo "=== Getting ready to change your shell to zsh. ==="
        if ! grep -qs "$(command -v zsh)" /etc/shells; then
          echo "It looks like your version of zsh is missing from ${bold}/etc/shells${normal}."
          echo "It must be added there manually before your shell can be changed."
          echo "Open ${bold}/etc/shells${normal} with your favorite text editor,"
          echo "then add ${bold}$(command -v zsh)${normal} in a new line and save the file."
          echo -n "Once you've added it, press ${bold}y${normal} to continue, or ${bold}n${normal} to cancel: "
          read -r -n 1 response
          if [ "$response" = "y" ]; then
            change_shell_to_zsh
          else
            fancy_echo "Shell will not be changed."
          fi
        else
          change_shell_to_zsh
        fi
      else
        fancy_echo "Shell will not be changed."
      fi
    else
      fancy_echo "CI System detected, will not change shells"
    fi
    ;;
esac
