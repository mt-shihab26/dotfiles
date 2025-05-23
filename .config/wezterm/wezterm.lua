local wezterm = require "wezterm"

wezterm.on("gui-startup", function()
    local _, _, window = wezterm.mux.spawn_window {}
    window:gui_window():maximize()
end)

return {
    -- Program settings
    default_prog = { "tmux", "new-session", "-A", "-s", "init" },

    -- Appearance
    color_scheme = "Tokyo Night",
    window_background_opacity = 0.95,

    -- Window settings
    enable_tab_bar = false,
    window_decorations = "NONE",

    -- Font settings
    font = wezterm.font "CaskaydiaMono Nerd Font",
    font_size = 12,

    -- Prevent window from closing when running 'exit'
    -- exit_behavior = "Hold",
    -- exit_behavior_messaging = "Brief",

    enable_wayland = false,
}
