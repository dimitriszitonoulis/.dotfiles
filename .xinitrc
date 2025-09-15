#!/bin/sh

# kill existing instances of dwmblocks
pkill -x dwmblocks 2>/dev/null

# set wallpaper
feh --bg-center "$HOME/Pictures/wallpapers/portal-aperture-science-dual-monitor-wallpaper.jpg" &

# run dwm blocks in backround
dwmblocks &

# start dwm
exec dwm
