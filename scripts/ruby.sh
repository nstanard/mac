#!/bin/bash

. ./functions.sh --source-only

export GEM_HOME="$HOME/.gem"; # https://github.com/rbenv/rbenv/issues/1267

# shellcheck disable=SC2016
append_to_file "$HOME/.gemrc" 'gem: --no-document'

check_processor_and_set_chruby_source_strings

if command -v rbenv >/dev/null || command -v rvm >/dev/null; then
  fancy_echo 'We recommend chruby and ruby-install over RVM or rbenv.'
  echo "Please uninstall RVM or rbenv, and remove any related lines from $shell_file, then run this script again."
  echo "To uninstall RVM, run 'rvm implode'. To uninstall rbenv, follow the instructions here: https://github.com/rbenv/rbenv#uninstalling-rbenv"
else
  if ! brew_is_installed "chruby"; then
    fancy_echo 'Installing chruby, ruby-install, and Ruby 2.7.2 ...'

    brew bundle --file=- <<EOF
    brew 'chruby'
    brew 'ruby-install'
EOF

    ruby-install ruby-2.7.2 -- --with-openssl-dir="$(brew --prefix openssl)"
    configure_shell_file_for_chruby "2.7.2"
    switch_to_ruby "2.7.2"
  else
    brew bundle --file=- <<EOF
    brew 'chruby'
    brew 'ruby-install'
EOF

    fancy_echo 'Checking if a newer version of Ruby is available...'

    ruby-install --latest > /dev/null
    latest_stable_ruby="$(cat < "$HOME/.cache/ruby-install/ruby/stable.txt" | tail -n1)"

    if ! [ "$latest_stable_ruby" = "$(latest_installed_ruby)" ]; then
      fancy_echo "Installing latest stable Ruby version: $latest_stable_ruby"
      ruby-install ruby -- --with-openssl-dir="$(brew --prefix openssl)"
      configure_shell_file_for_chruby "$(latest_installed_ruby)"
      switch_to_ruby "$(latest_installed_ruby)"
    else
      fancy_echo 'You have the latest version of Ruby'
    fi

    if ! [ "$(ruby_2_7_2_is_installed)" = "$HOME/.rubies/ruby-2.7.2" ]; then
      fancy_echo "Installing Ruby 2.7.2 ..."
      ruby-install ruby-2.7.2 -- --with-openssl-dir="$(brew --prefix openssl)"
      configure_shell_file_for_chruby "2.7.2"
      switch_to_ruby "2.7.2"
    fi

    configure_shell_file_for_chruby "2.7.2"
  fi
fi

fancy_echo 'Updating Rubygems...'
switch_to_ruby "2.7.2"
gem update --system

fancy_echo 'Installing or updating Bundler'
gem_install_or_update 'bundler'
