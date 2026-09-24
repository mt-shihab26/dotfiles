vim.pack.add { "https://github.com/folke/snacks.nvim" }

local snacks = require "snacks"

-- Opening an image file renders it in the buffer via the kitty graphics protocol
snacks.setup {
    image = { enabled = true },
}

-- Lua has no round(), and a 0 cell image can't be placed
local function round(n)
    return math.max(1, math.floor(n + 0.5))
end

-- Snacks only shrinks large images to fit the window. For image buffers, also scale small
-- images up so they always fill the window's width or height (like css `object-fit: contain`).
local function contain_images()
    local util = snacks.image.util
    local placement = snacks.image.placement

    local fit = util.fit
    local state = placement.state
    local contain = false

    util.fit = function(file, cells, opts)
        if not contain then
            return fit(file, cells, opts)
        end
        local natural = fit(file, { width = math.huge, height = math.huge }, opts)
        local scale = math.min(cells.width / natural.width, cells.height / natural.height)
        return {
            width = round(natural.width * scale),
            height = round(natural.height * scale),
        }
    end

    placement.state = function(self, ...)
        contain = vim.bo[self.buf].filetype == "image"
        local ok, result = pcall(state, self, ...)
        contain = false
        if not ok then
            error(result, 0)
        end
        return result
    end
end

-- Snacks hides an image once its buffer leaves every window, but only inline docs ever show
-- it again. Un-hide image buffers when they are displayed so switching back re-renders them.
local function reshow_images()
    local placement = snacks.image.placement

    local state = placement.state

    placement.state = function(self, ...)
        if vim.bo[self.buf].filetype == "image" and self.hidden and #self:wins() > 0 then
            self.hidden = false
        end
        return state(self, ...)
    end
end

contain_images()
reshow_images()
