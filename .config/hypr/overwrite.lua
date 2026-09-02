-- require("hypr.overwrite")

hl.config {
    input = {
        -- Use multiple keyboard layouts and switch between them with Left Alt + Right Alt.
        kb_layout = "us,bd",
        kb_variant = ",probhat",
        kb_options = "compose:caps,shift:both_capslock_cancel,grp:alts_toggle",

        touchpad = {
            tap_to_click = true,
            clickfinger_behavior = true,
            natural_scroll = true,
            drag_3fg = 1,
        },
    },
}

-- Switch workspaces with ALT + [1-9] (code:10-code:18 are the number-row keys).
o.bind("ALT + code:10", "Switch to workspace 1", hl.dsp.focus { workspace = "1" })
o.bind("ALT + code:11", "Switch to workspace 2", hl.dsp.focus { workspace = "2" })
o.bind("ALT + code:12", "Switch to workspace 3", hl.dsp.focus { workspace = "3" })
o.bind("ALT + code:13", "Switch to workspace 4", hl.dsp.focus { workspace = "4" })
o.bind("ALT + code:14", "Switch to workspace 5", hl.dsp.focus { workspace = "5" })
o.bind("ALT + code:15", "Switch to workspace 6", hl.dsp.focus { workspace = "6" })
o.bind("ALT + code:16", "Switch to workspace 7", hl.dsp.focus { workspace = "7" })
o.bind("ALT + code:17", "Switch to workspace 8", hl.dsp.focus { workspace = "8" })
o.bind("ALT + code:18", "Switch to workspace 9", hl.dsp.focus { workspace = "9" })

-- Cycle wallpaper on startup.
o.launch_on_start "wallpaper-cycle"

-- Clear clipboard manager history.
o.bind("CTRL + SHIFT + DELETE", "Clear clipboard history", "clipboard-clear")
