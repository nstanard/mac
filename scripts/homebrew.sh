#!/bin/bash

# Note: Sourced from calling context path, not this files location
. ./functions.sh --source-only

if ! command -v brew >/dev/null; then
  fancy_echo "Installing Homebrew ..."
    curl -fsS \
      'https://raw.githubusercontent.com/Homebrew/install/master/install' | ruby

    # shellcheck disable=SC2016
    append_to_file "$shell_file" 'export PATH="/usr/local/bin:$PATH"'
else
  fancy_echo "Homebrew already installed. Skipping ..."
fi

# Remove brew-cask since it is now installed as part of brew tap caskroom/cask.
# See https://github.com/caskroom/homebrew-cask/releases/tag/v0.60.0
if brew_is_installed 'brew-cask'; then
  brew uninstall --force 'brew-cask'
fi

if tap_is_installed 'caskroom/versions'; then
  brew untap caskroom/versions
fi

fancy_echo "Updating Homebrew ..."
cd "$(brew --repo)" && git fetch && git reset --hard origin/master && brew update

fancy_echo "Verifying the Homebrew installation..."
if brew doctor; then
  fancy_echo "Your Homebrew installation is good to go."
else
  fancy_echo "Your Homebrew installation reported some errors or warnings."
  echo "Review the Homebrew messages to see if any action is needed."
fi

fancy_echo "Installing formulas and casks from the Brewfile ..."
if brew bundle --file="$MAC_SETUP_FOLDER/Brewfile"; then
  fancy_echo "All formulas and casks were installed successfully."
else
  fancy_echo "Some formulas or casks failed to install."
  echo "This is usually due to one of the Mac apps being already installed,"
  echo "in which case, you can ignore these errors."
fi

# TODO: Check owner of all contenxt of /usr/local (brew prefix) and only do this if it's not equal to whoami
fancy_echo "Setting you as the owner of -R /usr/local (or whatever the brew prefix is) ..."
sudo chown -R $(whoami) $(brew --prefix)/*
