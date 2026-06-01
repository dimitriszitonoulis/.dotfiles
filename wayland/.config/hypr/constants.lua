local M = {}

-- Set programs that you use
M.TERMINAL = "kitty"
M.FILEMANAGER = M.TERMINAL .. " -e yazi"
M.MENU = 'zsh -c "rofi -show run"'
-- local menu = rofi -show combi -modi combi,drun,run -combi-modi drun,run
M.BROWSER = "firefox"
M.MUSIC_PLAYER = "spotify-launcher"
M.NOTES = "obsidian"

return M
