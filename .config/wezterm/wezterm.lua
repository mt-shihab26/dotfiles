local wezterm = require "wezterm"

local config = wezterm.config_builder()

config.color_scheme = "Tokyo Night"

config.font = wezterm.font "JetBrains Mono"
config.font_size = 16

config.enable_tab_bar = false

config.window_decorations = "RESIZE"

config.window_background_opacity = 0.90
config.macos_window_background_blur = 10

config.window_padding = {
    left = 8,
    right = 8,
    top = 8,
    bottom = 8,
}

return config
