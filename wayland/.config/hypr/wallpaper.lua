local wallpaper = "$HOME/Pictures/wallpapers/gray-fractal-43414-2880x1800.jpg"

hl.on("hyprland.start", function()
    hl.exec_cmd("swaybg -m center -i" .. wallpaper)
end)
