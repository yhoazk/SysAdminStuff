# Fedora basic packages:


### Install development tools
Fedora provides group install packager, to list the available packages: `dnf grouplist`

To install one of the listed packages: `dnf groupinstall "<NameOfThePackage>"`

### Install powerline for terminal

[src](https://fedoramagazine.org/add-power-terminal-powerline/)

```
sudo dnf install powerline powerline-fonts
```

Then is necessary to modify the `.bashrc` to start with this instead of the default theme.
```
if [ -f `which powerline-daemon` ]; then
  powerline-daemon -q
  POWERLINE_BASH_CONTINUATION=1
  POWERLINE_BASH_SELECT=1
  . /usr/share/powerline/bash/powerline.sh
fi
```

Now for `tmux`:
```
sudo dnf install tmux-powerline
```

Now add this line to your ~/.tmux.conf file:
```
source "/usr/share/tmux/powerline.conf"
```
Next, remove or comment out any lines in your tmux configuration for status bar length or content. Examples of these settings are status-left, status-right, status-left-length, and status-right-length.

Your user configuration is stored in ~/.tmux.conf. If you don’t have one, copy an example from the web or /usr/share/tmux to ~/.tmux.conf, and then edit.

When you next start tmux, you should see the powerline status bar:

For vim
```
sudo dnf install vim-powerline
```

Add the next lines to the `~/.vimrc`

```
python3 from powerline.vim import setup as powerline_setup
python3 powerline_setup()
python3 del powerline_setup
set laststatus=2 " Always display the statusline in all windows
set showtabline=2 " Always display the tabline, even if there is only one tab
set noshowmode " Hide the default mode text (e.g. -- INSERT -- below the statusline)
set t_Co=256
```

### Install ultimate gvim



### Clean occupied space in `/var/cache/PackageKit`


This behaviour is a documented [bug](https://bugs.freedesktop.org/show_bug.cgi?id=80053#c6) and the contents can be cleared with the next command:
```
$ sudo pkcon refresh force -c -11
```
