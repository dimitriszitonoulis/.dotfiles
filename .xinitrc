#!/bin/sh

# kill existing instances of dwmblocks
pkill -x dwmblocks 2>/dev/null

# enable numlock
numlockx &

# set wallpaper
feh --bg-center "$HOME/Pictures/wallpapers/portal-aperture-science-dual-monitor-wallpaper.jpg" &

# start compositor
picom &

# when 2nd monitor is connected place it to the right of main monitor
main_monitor="eDP-1"
second_monitor="HDMI-1"
# xrandr --output "$second_monitor" --auto --left-of "$main_monitor"
xrandr --output "$second_monitor" --off --output "$main_monitor" --auto

# run dwm blocks in backround
dwmblocks &

# start dwm
exec dwm
