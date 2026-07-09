local wezterm = require "wezterm"
local config = wezterm.config_builder()

-- Run via XWayland to avoid Wayland/Hyprland launch issues
config.enable_wayland = false

-- Font with explicit Bengali fallback so HarfBuzz shapes the full run correctly
config.font = wezterm.font_with_fallback {
    "JetBrainsMono Nerd Font",
    "Noto Sans Bengali",
}
config.font_size = 12.0

-- Window
config.window_padding = { left = 2, right = 2, top = 2, bottom = 2 }
config.window_decorations = "NONE"

-- Tab bar
config.enable_tab_bar = false

-- Bell
config.audible_bell = "Disabled"

-- Cursor
config.default_cursor_style = "BlinkingBlock"
config.cursor_blink_rate = 0

return config
