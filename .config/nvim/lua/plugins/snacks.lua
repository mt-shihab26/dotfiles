vim.pack.add { "https://github.com/folke/snacks.nvim" }

local snacks = require "snacks"

-- Opening an image file renders it in the buffer via the kitty graphics protocol
snacks.setup {
    image = { enabled = true },
}

-- Snacks only shrinks large images to fit the window. For image buffers, also scale small
-- images up so they always fill the window's width or height (like css `object-fit: contain`).
-- Snacks helper module that holds the `fit` function (calculates the image size in cells)
local util = snacks.image.util
-- Snacks class that draws an image in a window, its `state` method calls `util.fit`
local placement = snacks.image.placement
-- Keep the original `fit` so we can still call it (we replace `util.fit` below)
local fit = util.fit

-- Round to the nearest whole cell (at least 1, a 0 cell image can't be placed)
-- Lua has no round(), so we add half a cell before `math.floor`
local function round(n)
    return math.max(1, math.floor(n + 0.5))
end

-- True only while `placement.state` (wrapped below) runs for an image buffer, so that
-- inline images in markdown and other docs keep the default sizing
local contain = false

-- Replace `fit`: `cells` is the window size in cells, the return value is the image size in cells
util.fit = function(file, cells, opts)
    -- Not an image buffer: use the original behavior (only shrink large images)
    if not contain then
        return fit(file, cells, opts)
    end
    -- Ask the original `fit` with an unlimited window, which returns the image's natural size in cells
    local natural = fit(file, { width = math.huge, height = math.huge }, opts)
    -- Scale factor that makes the image touch the window on the tighter side:
    -- the smaller of width ratio and height ratio, so the image never overflows (contain)
    -- A factor above 1 scales small images up, below 1 scales large images down
    local scale = math.min(cells.width / natural.width, cells.height / natural.height)
    return {
        -- Apply the same factor to both sides to keep the aspect ratio, in whole cells
        width = round(natural.width * scale),
        height = round(natural.height * scale),
    }
end

local state = placement.state
placement.state = function(self, ...)
    contain = vim.bo[self.buf].filetype == "image"
    -- Snacks hides an image once its buffer leaves every window, but only inline docs ever show
    -- it again. Un-hide image buffers when they are displayed so switching back re-renders them.
    if contain and self.hidden and #self:wins() > 0 then
        self.hidden = false
    end
    local ok, result = pcall(state, self, ...)
    contain = false
    if not ok then
        error(result, 0)
    end
    return result
end
