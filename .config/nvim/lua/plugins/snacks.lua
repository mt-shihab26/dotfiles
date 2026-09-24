vim.pack.add { "https://github.com/folke/snacks.nvim" }

local snacks = require "snacks"

-- Opening an image file renders it in the buffer via the kitty graphics protocol
snacks.setup {
    image = { enabled = true },
}

-- Snacks only shrinks large images to fit the window. For image buffers, also scale small
-- images up so they always fill the window's width or height (like css `object-fit: contain`).
local util = snacks.image.util
local placement = snacks.image.placement
local fit = util.fit
local contain = false

util.fit = function(file, cells, opts)
    if not contain then
        return fit(file, cells, opts)
    end
    local natural = fit(file, { width = math.huge, height = math.huge }, opts)
    local scale = math.min(cells.width / natural.width, cells.height / natural.height)
    return {
        width = math.max(1, math.floor(natural.width * scale + 0.5)),
        height = math.max(1, math.floor(natural.height * scale + 0.5)),
    }
end

local state = placement.state
placement.state = function(self, ...)
    contain = vim.bo[self.buf].filetype == "image"
    local ok, result = pcall(state, self, ...)
    contain = false
    if not ok then
        error(result, 0)
    end
    return result
end
