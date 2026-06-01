# See https://wiki.hypr.land/Configuring/Gestures

hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace"
})

hl.gesture({
    fingers = 2,
    direction = "pinchin",
    action = "cursorZoom",
    zoom_level = 2
})

hl.gesture({
    fingers = 2,
    direction = "pinchout",
    action = "cursorZoom",
    zoom_level = -2
})

hl.gesture({
    fingers = 4,
    direction = "horizontal",
    action = "workspace"
})

hl.gesture({
    fingers = 4,
    direction = "up",
    action = "fullscreen"
})

hl.gesture({
    fingers = 4,
    direction = "down",
    action = "close",
    mods = "Alt"
})
