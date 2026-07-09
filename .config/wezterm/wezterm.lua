local wezterm = require 'wezterm'
local config = wezterm.config_builder()

-- Run via XWayland to avoid Wayland/Hyprland launch issues
config.enable_wayland = false

-- Font: match Kitty setup
config.font = wezterm.font('JetBrainsMono Nerd Font')
config.font_size = 12.0

-- Bengali complex script shaping is handled automatically by WezTerm's
-- HarfBuzz integration -- no symbol_map needed unlike Kitty

-- Window
config.window_padding = { left = 2, right = 2, top = 2, bottom = 2 }
config.window_decorations = 'NONE'

-- Tab bar
config.enable_tab_bar = false

-- Bell
config.audible_bell = 'Disabled'

-- Cursor
config.default_cursor_style = 'BlinkingBlock'
config.cursor_blink_rate = 0

return config
