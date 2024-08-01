-- main configuration file
local wezterm = require "wezterm"
local config = wezterm.config_builder()

local background = require "background"
local typography = require "typography"

local function merge(destination, source)
    for k, v in pairs(source) do
        destination[k] = v
    end
end

config = {
    automatically_reload_config = true,
    enable_tab_bar = true,
    window_decorations = "RESIZE",
    -- default_cursor_style = "BlinkingBar",
    color_scheme = "deep",
    adjust_window_size_when_changing_font_size = false,
    use_fancy_tab_bar = false,
    hide_tab_bar_if_only_one_tab = true,
    window_padding = { left = 3, right = 3, top = 25, bottom = 0 },
    background = background,
}

merge(config, typography)

return config
