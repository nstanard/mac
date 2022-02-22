Mac
======

Mac is a script to set up a macOS computer for web development, and to keep
it up to date.

If you want - the script also lightly customizes your shell prompt so that it displays your
current directory in orange, followed by the current Ruby version or gemset in
green, and sets the prompt character to `$`. It also allows you to easily
distinguish directories from files when running `ls` by displaying directories
in a different color. Below is a screenshot showing what the colors look like
when using the default Terminal white background, the Solarized Dark theme, and the Solarized Light theme.

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
