#!/bin/bash

echo ""
read -p "Would you like to configure Ruby? [Y/n]: " response
response=${response:-y}
if [ "$response" = "y" ]; then

  # shellcheck disable=SC2016
  append_to_file "$shell_file" 'eval "$(hub alias -s)"'

  append_to_file "$HOME/.gemrc" 'gem: --no-document'

if command -v rbenv >/dev/null || command -v rvm >/dev/null; then
  fancy_echo 'We recommend chruby and ruby-install over RVM or rbenv'
else
  if ! brew_is_installed "chruby"; then
    fancy_echo 'Installing chruby, ruby-install, and the latest Ruby...'

    brew bundle --file=- <<EOF
    brew 'chruby'
    brew 'ruby-install'
EOF

    append_to_file "$shell_file" 'source /usr/local/share/chruby/chruby.sh'
    append_to_file "$shell_file" 'source /usr/local/share/chruby/auto.sh'

    ruby-install ruby

    append_to_file "$shell_file" "chruby ruby-$(latest_installed_ruby)"

    switch_to_latest_ruby
  else
    brew bundle --file=- <<EOF
    brew 'chruby'
    brew 'ruby-install'
EOF
    fancy_echo 'Checking if a newer version of Ruby is available...'
    switch_to_latest_ruby

    ruby-install --latest > /dev/null
    latest_stable_ruby="$(cat < "$HOME/.cache/ruby-install/ruby/stable.txt" | tail -n1)"

    if ! [ "$latest_stable_ruby" = "$(latest_installed_ruby)" ]; then
      fancy_echo "Installing latest stable Ruby version: $latest_stable_ruby"
      ruby-install ruby
    else
      fancy_echo 'You have the latest version of Ruby'
    fi
  fi
fi

  fancy_echo 'Updating Rubygems...'
  gem update --system

  gem_install_or_update 'bundler'

  fancy_echo "Configuring Bundler ..."
  number_of_cores=$(sysctl -n hw.ncpu)
  bundle config --global jobs $((number_of_cores - 1))

  fancy_echo '...Finished Ruby installation checks.'

fi
