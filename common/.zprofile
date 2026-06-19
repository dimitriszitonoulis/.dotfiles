export JAVA_HOME=/usr/lib/jvm/java-21-openjdk

export PATH="$PATH:\
$HOME/jason/bin:\
$HOME/.local/share/bob/nvim-bin:\
$HOME/neovim/bin:\
$HOME/appimages/:\
$HOME/scripts/:\
$HOME/scripts/tmux_scripts/:\
$HOME/scripts/desktop_controls/:\
$JAVA_HOME/bin"

# to start display manager after user login
if [[ -z "$DISPLAY" ]] && [[ $(tty) = /dev/tty1 ]]; then
    # exec startx
    #exec Hyprland
    exec start-hyprland
fi
