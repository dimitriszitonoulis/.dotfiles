-- # See https://wiki.hypr.land/Configuring/Window-Rules/ for more
-- # See https://wiki.hypr.land/Configuring/Workspace-Rules/ for workspace rules
--
-- # Example windowrule
-- # windowrule = float,class:^(kitty)$,title:^(kitty)$
--
-- # Ignore maximize requests from apps. You'll probably like this.
-- windowrule = suppress_event maximize, match:class .*
--
-- # Fix some dragging issues with XWayland
-- windowrule = no_focus on, match:class ^$,match:title ^$, match:xwayland 1, match:float 1, match:fullscreen 0, match:pin 0
--
-- # opens spotify in a special workspace with the name music
-- windowrule = workspace special:music, match:class ^(spotify)$
-- # opens obsidian in a special workspace with the name notes
-- windowrule = workspace special:notes, match:class ^(obsidian)$
--
-- windowrule = workspace special:terminal silent, match:class ^(special_terminal)$
--
-- layerrule = blur on, match:class waybar



-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- and https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

-- Example window rules that are useful

local suppressMaximizeRule = hl.window_rule({
    -- Ignore maximize requests from all apps. You'll probably like this.
    name           = "suppress-maximize-events",
    match          = { class = ".*" },

    suppress_event = "maximize",
})
-- suppressMaximizeRule:set_enabled(false)

hl.window_rule({
    -- Fix some dragging issues with XWayland
    name     = "fix-xwayland-drags",
    match    = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },

    no_focus = true,
})

-- Layer rules also return a handle.
-- local overlayLayerRule = hl.layer_rule({
--     name  = "no-anim-overlay",
--     match = { namespace = "^my-overlay$" },
--     no_anim = true,
-- })
-- overlayLayerRule:set_enabled(false)

-- I DID NOT HAVE THIS
-- Hyprland-run windowrule
hl.window_rule({
    name  = "move-hyprland-run",
    match = { class = "hyprland-run" },

    move  = "20 monitor_h-120",
    float = true,
})


hl.window_rule({
    name      = "spotify-workspace",
    match     = { class = "^(Spotify)$" },
    workspace = "special:music"
})

hl.window_rule({
    name      = "notes-workspace",
    match     = { class = "^(md.obsidian.Obsidian)$" },
    workspace = "special:notes"
})

hl.window_rule({
    name      = "terminal-workspace",
    match     = { class = "^(special_terminal)$" },
    workspace = "special:terminal silent"
})

hl.layer_rule({
    name  = "blur-waybar",
    blur  = true,
    match = { class = "waybar" },
})

-- Disable blur for firefox
hl.window_rule({
    name    = "firefox-no-blur",
    match   = { class = "firefox" },
    no_blur = true
})
