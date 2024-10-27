local disable = function(keymaps)
    local all_modes = { "n", "i", "v", "x", "s", "o", "t", "c" }

    -- Unmap each keymap in all modes
    for _, mapping in ipairs(keymaps) do
        for _, mode in ipairs(all_modes) do
            -- pcall to prevent errors if the mapping doesn't exist in a particular mode
            pcall(function()
                vim.keymap.del(mode, mapping)
            end)
        end
    end
end

local general = {}

disable(general)
