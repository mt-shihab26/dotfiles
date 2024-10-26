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

local telescope_keymaps = {
    -- Basic mappings
    "<leader>/",
    "<leader>,",
    "<leader>:",
    "<leader><space>",
    -- Find mappings
    "<leader>fb",
    "<leader>fc",
    "<leader>ff",
    "<leader>fF",
    "<leader>fg",
    "<leader>fr",
    "<leader>fR",
    -- Git mappings
    "<leader>gc",
    "<leader>gs",
    -- Search mappings
    '<leader>s"',
    "<leader>sa",
    "<leader>sb",
    "<leader>sc",
    "<leader>sC",
    "<leader>sd",
    "<leader>sD",
    "<leader>sg",
    "<leader>sG",
    "<leader>sh",
    "<leader>sH",
    "<leader>sj",
    "<leader>sk",
    "<leader>sl",
    "<leader>sM",
    "<leader>sm",
    "<leader>so",
    "<leader>sR",
    "<leader>sq",
    "<leader>sw",
    "<leader>sW",
    "<leader>uC",
    "<leader>ss",
    "<leader>sS",
}

disable(telescope_keymaps)
