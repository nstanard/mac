#!/bin/bash

pathmunge () {
    if ! echo "$PATH" | grep -Eq "(^|:)$1($|:)"; then
        if [ "$2" = "after" ] ; then
            PATH="$PATH:$1"
        else
            PATH="$1:$PATH"
        fi
    fi
}

append_to_file() {
  local file="$1"
  local text="$2"

  if ! grep -qs "^$text$" "$file"; then
    printf "\\n%s\\n" "$text" >> "$file"
  fi
}

npmp () {
    pushd "$1" && npm publish && popd && clear && ls
}

fancy_echo() {
  local fmt="$1"; shift

  # shellcheck disable=SC2059
  printf "\\n$fmt\\n" "$@"
}

brew_is_installed() {
  brew list -1 | grep -Fqx "$1"
}

tap_is_installed() {
  brew tap | grep -Fqx "$1"
}

create_zshrc_and_set_it_as_shell_file() {
  if [ ! -f "$HOME/.zshrc" ]; then
    touch "$HOME/.zshrc"
  fi

  shell_file="$HOME/.zshrc"
  # TODO: remove existing shell_file line from $devrc
  # append_to_file $devrc "export shell_file=$shell_file;"
  # TODO: remove existing source devrc from shell_file
  # TODO: source devrc from shell_file
}

create_profile_and_set_it_as_shell_file() {
  if [ ! -f "$HOME/.profile" ]; then
    touch "$HOME/.profile"
  fi

  shell_file="$HOME/.profile"
  # TODO: remove existing shell_file line from $devrc
  # append_to_file $devrc "export shell_file=$shell_file;"
  # TODO: remove existing source devrc from shell_file
  # TODO: source devrc from shell_file
}

change_shell_to_zsh() {
  fancy_echo "Please enter your password to continue."
  echo "Note that there won't be visual feedback when you type your password."
  echo "Type it slowly and press return, or press control-c to cancel the switch to zsh and exit the script."
  create_zshrc_and_set_it_as_shell_file
  chsh -s "$(command -v zsh)"
  echo "Note that you can always switch back to ${bold}bash${normal} if you change your mind."
  echo "The instructions for changing shells manually are available in the README."
}

gem_install_or_update() {
  if gem list "$1" | grep "^$1 ("; then
    fancy_echo "Updating %s ..." "$1"
    gem update "$@"
  else
    fancy_echo "Installing %s ..." "$1"
    gem install "$@"
  fi
}

app_is_installed() {
  local app_name
  app_name=$(echo "$1" | cut -d'-' -f1)
  find /Applications -iname "$app_name*" -maxdepth 1 | grep -E '.app' > /dev/null
}

latest_installed_ruby() {
  find "$HOME/.rubies" -maxdepth 1 -name 'ruby-*' | tail -n1 | grep -E -o '\d+\.\d+\.\d+'
}

switch_to_latest_ruby() {
  # shellcheck disable=SC1091
  . /usr/local/share/chruby/chruby.sh
  chruby "ruby-$(latest_installed_ruby)"
}

no_prompt_customizations_in_shell_file() {
  ! grep -qs -e "PS1=" -e "precmd" -e "PROMPT=" "$shell_file"
}

no_zsh_frameworks() {
  [ ! -d "$HOME/.oh-my-zsh" ] && [ ! -d "$HOME/.zpresto" ] && [ ! -d "$HOME/.zim" ] && [ ! -d "$HOME/.zplug" ]
}

apple_m1() {
  sysctl -n machdep.cpu.brand_string | grep "Apple M1"
}

check_processor_and_set_chruby_source_strings() {
  if apple_m1 && ! rosetta; then
    chruby_source_string="source /opt/homebrew/opt/chruby/share/chruby/chruby.sh"
    auto_source_string="source /opt/homebrew/opt/chruby/share/chruby/auto.sh"
  else
    chruby_source_string="source /usr/local/share/chruby/chruby.sh"
    auto_source_string="source /usr/local/share/chruby/auto.sh"
  fi
}
