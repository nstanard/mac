<!-- https://gist.github.com/millermedeiros/6615994 -->
<!-- https://github.com/monfresh/laptop -->
<!-- https://github.com/thoughtbot/laptop -->

<!-- Hosts location: /etc/hosts -->

<!-- TODO:

   Explore other peoples shortcuts and scripts:
      https://gist.github.com/kjbrum/77b7af04191267b053e9
      https://ostechnix.com/list-useful-bash-keyboard-shortcuts/
      https://github.com/fliptheweb/bash-shortcuts-cheat-sheet

      https://www.cyberciti.biz/tips/bash-aliases-mac-centos-linux-unix.html
      https://robertharder.wordpress.com/2011/03/17/bash-profile-sharing-and-useful-scripts/
      https://dev.to/aviaryan/some-helpful-bash-scripts-i-use-daily-40bd

   - Create a node.js wrapper to pick which parts to run... then execute the bash file passing in args to control which parts run?
      - https://opensource.com/article/18/7/node-js-interactive-cli

   - Add back:
      alias reload="source ~/.profile"
      alias code="open -a 'Visual Studio Code.app'"

      alias watch="npm run watch"
      alias test="npm run test"

      alias lc="alias"
      alias ll="ls -lsG"
      alias ls="exa --long --header --git"
      # DECLARABLES #
        export LSCOLORS="fafxcxdxbxegedabagacad"
        export ANDROID_HOME=$HOME/Library/Android/sdk
        export PATH=$PATH:$ANDROID_HOME//platform-tools
        #export PS1="$: "
        export PS1="[\u@\h \W]\\$ "

      # GITHUB #

      ghns ()
      {
      # make it read the existing .gitconfig file and make a backup with time in the name
      # write to ~/.gitconfig
      cat >  "$HOME/.gitconfig" <<EOF
      [user]
            name = Neal Stanard
            email = nstanard@gmail.com
            username = nstanard
      EOF

      cat >  "$HOME/.ssh/config" <<EOF
      Host github.com
            HostName github.com
            User git
            AddKeysToAgent yes
            UseKeychain yes
            IdentityFile ~/.ssh/id_rsa
            IdentitiesOnly yes
      EOF

      }

 -->

Laptop
======
Laptop is a script to set up a macOS computer for web development, and to keep
it up to date.

It can be run multiple times on the same machine safely. It installs,
upgrades, or skips packages based on what is already installed on the machine.

If you want - the script also lightly customizes your shell prompt so that it displays your
current directory in orange, followed by the current Ruby version or gemset in
green, and sets the prompt character to `$`. It also allows you to easily
distinguish directories from files when running `ls` by displaying directories
in a different color. Below is a screenshot showing what the colors look like
when using the default Terminal white background, the Solarized Dark theme, and the Solarized Light theme.

If you want to use the [Solarized](http://ethanschoonover.com/solarized)
themes, run the following commands in your Terminal:
```bash
cd ~

curl --remote-name https://raw.githubusercontent.com/tomislav/osx-terminal.app-colors-solarized/master/Solarized%20Dark.terminal

curl --remote-name https://raw.githubusercontent.com/tomislav/osx-terminal.app-colors-solarized/master/Solarized%20Light.terminal

open Solarized%20Dark.terminal

open Solarized%20Light.terminal
```

This will add the Solarized themes to your Terminal's Profiles, and if you want to set one of them as the default, go to your Terminal's Preferences,
click on the Settings tab, scroll down to the Solarized Profile, click on it,
then click the Default button. When you open a new window or tab (or if you quit and relaunch Terminal), it will use the Solarized theme.

If you want to try out different prompt colors other than orange and green,
open your `.zshrc` or `.bash_profile` in Sublime Text:

```sh
subl ~/.zshrc
```

Define a new color variable using any of the 256 possible [Xterm colors](http://upload.wikimedia.org/wikipedia/commons/9/95/Xterm_color_chart.png). For example:

```
BLUE=$(tput setaf 190)
```

Then in the line that contains `PS1=`, replace `{ORANGE}` or `{GREEN}` with
`{BLUE}`. Save the file, then open a new Terminal window or tab to see the changes.


How to manage background services
----------------------------------------------------------
The script does not automatically launch these services after installation
because you might not need or want them to be running. With Homebrew Services,
starting, stopping, or restarting these services is as easy as:

```
brew services start|stop|restart [name of service]
```

For example:

```
brew services start postgresql
```

To see a list of all installed services:

```
brew services list
```

To start all services at once:

```
brew services start --all
```

How to switch your shell back to bash from zsh (or vice versa)
--------------------------------------------------------------
1. Find out which shell you're currently running: `echo $SHELL`
2. Find out the location of the shell you want to switch to. For example, if
   you want to switch to `bash`, run `which bash`.
3. Verify if the shell location is included in `/etc/shells`.
   Run `cat /etc/shells` to see the contents of the file.
4. If the location of the shell is included, run `chsh -s [the location of the shell]`.
   For example, if `which bash` returned `/bin/bash`, you would run `chsh -s /bin/bash`.

   If the location of the shell is not in `/etc/shells`, add it, then run the `chsh` command.
   If you have Sublime Text, you can open the file by running `subl /etc/shells`.
