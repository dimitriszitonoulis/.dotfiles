# See https://wiki.hypr.land/Configuring/Keywords/

local constants = require("constants")

-- $mainMod = SUPER # Sets "Windows" key as main modifier
local mainMod = "SUPER"
local appMod = "SUPER + SHIFT"
local powerMod = "SUPER + ALT"

local terminal = constants.TERMINAL
local file_manager = constants.FILEMANAGER
local menu = constants.MENU
local browser = constants.BROWSER
local music_player = constants.MUSIC_PLAYER
local notes = constants.NOTES





-- Example binds, see https://wiki.hypr.land/Configuring/Basics/Binds/ for more
hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + C", hl.dsp.window.close())
-- closeWindowBind:set_enabled(false)
hl.bind(powerMod .. " + Q",
    hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))
hl.bind(mainMod .. " + F", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + P", hl.dsp.exec_cmd(menu))


-- master layout
hl.bind(appMod .. " + RETURN", hl.dsp.layout("swapwithmaster"))
hl.bind(mainMod .. " + O", hl.dsp.layout("addmaster"))
hl.bind(mainMod .. " + I", hl.dsp.layout("removemaster"))
hl.bind(mainMod .. " + J", hl.dsp.layout("cyclenext"))
hl.bind(mainMod .. " + K", hl.dsp.layout("cycleprev"))
hl.bind(mainMod .. " + H", hl.dsp.layout("mfact -0.05"))
hl.bind(mainMod .. " + L", hl.dsp.layout("mfact +0.05"))
-- monocle layout
-- hl.bind(mainMod .. " + M", hl.dsp.layout(""))

-- bind = $mainMod ALT, L, exec, hyprlock
-- bindl = $mainMod ALT, S, exec, systemctl suspend
-- bindl = $mainMod ALT, R, exec, reboot
-- bindl = $mainMod ALT, P, exec, poweroff

-- # dwindle layout
-- bind = $mainMod, G, pseudo, # dwindle
-- bind = $mainMod, J, togglesplit, # dwindle
-- # master layout
-- bind = $mainMod SHIFT, RETURN, layoutmsg, swapwithmaster
-- bind = $mainMod, O, layoutmsg, addmaster
-- bind = $mainMod, I, layoutmsg, removemaster
-- bind = $mainMod, J, layoutmsg, cyclenext
-- bind = $mainMod, K, layoutmsg, cycleprev
-- bind = $mainMod, H, layoutmsg, mfact -0.05
-- bind = $mainMod, L, layoutmsg, mfact +0.05

-- hide/show waybar
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd("killall -SIGUSR1 waybar || waybar"))


-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))


-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i, follow = false }))
end


-- Special workspace bindings
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("scratchpad"))
hl.bind(mainMod .. " + M", hl.dsp.workspace.toggle_special("music")) -- no keybind to send, apps are opened by default
hl.bind(mainMod .. " + N", hl.dsp.workspace.toggle_special("notes")) -- no keybind to send, apps are opened by default
hl.bind(mainMod .. " + T", hl.dsp.workspace.toggle_special("terminal"))
hl.bind(appMod .. " + S", hl.dsp.window.move({ workspace = "special:scratchpad" }))
hl.bind(appMod .. " + T", hl.dsp.window.move({ workspace = "special:terminal" }))


-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })


-- Application bindings
hl.bind(appMod .. " + W", hl.dsp.exec_cmd(browser))
hl.bind(appMod .. " + E", hl.dsp.exec_cmd(file_manager))
hl.bind(appMod .. " + M", hl.dsp.exec_cmd(music_player))
hl.bind(appMod .. " + B", hl.dsp.exec_cmd(terminal .. " -e bluetoothctl"))
hl.bind(appMod .. " + N", hl.dsp.exec_cmd(notes))


-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 2%+"),
    { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%-"),
    { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
    { locked = true, repeating = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
    { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 2%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 2%-"), { locked = true, repeating = true })


-- Requires playerctl
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })


-- screenshot keys
-- hl.bind(mainMod .. " + Print", hl.dsp.exec_cmd("flameshot screen -c -p ~/Pictures/Screenshots"))
-- hl.bind("Print", hl.dsp.exec_cmd("flameshot gui -c -p ~/Pictures/Screenshots"))
hl.bind(mainMod .. " + Print", hl.dsp.exec_cmd("grim"))
hl.bind("Print", hl.dsp.exec_cmd('grim -g "$(slurp)"'))


-- power keys
hl.bind(powerMod .. " + L", hl.dsp.exec_cmd("hyprlock"), { locked = true })
hl.bind(powerMod .. " + S", hl.dsp.exec_cmd("systemctl suspend"), { locked = true })
hl.bind(powerMod .. " + R", hl.dsp.exec_cmd("reboot"), { locked = true })
hl.bind(powerMod .. " + P", hl.dsp.exec_cmd("poweroff"), { locked = true })
-- screen
hl.bind(powerMod .. " + C", hl.dsp.exec_cmd("turn_off_screen.sh intel_backlight"))
hl.bind(powerMod .. " + N", hl.dsp.exec_cmd("shader_hypr.sh 3000"))

hl.bind(powerMod .. " + M", function()
    hl.config({
        general = {
            layout = "monocle"
        }
    })
end)

hl.bind(powerMod .. " + T", function()
    hl.config({
        general = {
            layout = "master"
        }
    })
end)
