# to start display manager after user login
if [[ -z "$DISPLAY" ]] && [[ $(tty) = /dev/tty1 ]]; then
	# exec startx
  exec Hyprland
fi
