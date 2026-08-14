-- Personal Hyprland overrides (converted from the legacy overwrite.conf).

local omarchy_monitor_scale = 1.25

hl.env("GDK_SCALE", tostring(omarchy_monitor_scale))
hl.monitor({ output = "", mode = "preferred", position = "auto", scale = omarchy_monitor_scale })
-- hl.monitor({ output = "", mode = "preferred", position = "auto", scale = 1.5 })

hl.config({
  input = {
    kb_layout = "us,bd",
    kb_variant = ",probhat",
    kb_options = "grp:alt_shift_toggle",

    touchpad = {
      tap_to_click = true,
      clickfinger_behavior = true,
      natural_scroll = true,
      drag_3fg = 1,
    },
  },

  general = {
    gaps_in = 0,
    gaps_out = 0,

    col = {
      active_border = { colors = { "rgba(224c66cc)", "rgba(1a3a2fcc)" }, angle = 45 },
      inactive_border = "rgba(3a3a3aaa)",
    },
  },
})

-- Switch workspaces with ALT + [1-9] (code:10-code:18 are the number-row keys).
-- NOTE: workspaces 7-9 reused code:15 (same key as workspace 6) in the original
-- overwrite.conf -- that looks like a copy/paste bug, kept as-is here.
o.bind("ALT + code:10", "Switch to workspace 1", hl.dsp.focus({ workspace = "1" }))
o.bind("ALT + code:11", "Switch to workspace 2", hl.dsp.focus({ workspace = "2" }))
o.bind("ALT + code:12", "Switch to workspace 3", hl.dsp.focus({ workspace = "3" }))
o.bind("ALT + code:13", "Switch to workspace 4", hl.dsp.focus({ workspace = "4" }))
o.bind("ALT + code:14", "Switch to workspace 5", hl.dsp.focus({ workspace = "5" }))
o.bind("ALT + code:15", "Switch to workspace 6", hl.dsp.focus({ workspace = "6" }))
o.bind("ALT + code:15", "Switch to workspace 7", hl.dsp.focus({ workspace = "7" }))
o.bind("ALT + code:15", "Switch to workspace 8", hl.dsp.focus({ workspace = "8" }))
o.bind("ALT + code:15", "Switch to workspace 9", hl.dsp.focus({ workspace = "9" }))

-- Godot game preview (DEBUG) windows -> workspace 4
o.window({ title = [[.*\(DEBUG\).*]] }, { workspace = "4 silent" })
o.window({ title = "^Godot$", float = true }, { workspace = "4 silent" })
