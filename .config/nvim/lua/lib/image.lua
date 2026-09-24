local M = {}

-- Cells the border takes on each side of the image
local border_size = 1

-- Lua has no round(), and a 0 cell image can't be placed
local function round(n)
    return math.max(1, math.floor(n + 0.5))
end

-- Snacks sizes images in whole cells, so a small image can get stretched by the rounding.
-- Find the largest whole-cell size inside the window that keeps the aspect ratio within a
-- small tolerance. It's fine to leave some space unused when no exact size fits.
---@param ratio number width / height of the image in cells
local function contain_cells(ratio, max_width, max_height)
    local tolerance = 0.02
    local width = math.max(1, math.min(max_width, math.floor(max_height * ratio)))
    for w = width, 1, -1 do
        local h = round(w / ratio)
        if h <= max_height and math.abs(w / h - ratio) <= ratio * tolerance then
            return { width = w, height = h }
        end
    end
    return { width = width, height = math.min(max_height, round(width / ratio)) }
end

-- Snacks only shrinks large images to fit the window. For image buffers, also scale small
-- images up so they always fill the window's width or height (like css `object-fit: contain`).
local function contain_images(snacks)
    local util = snacks.image.util
    local placement = snacks.image.placement

    local fit = util.fit
    local state = placement.state
    local contain = false

    util.fit = function(file, cells, opts)
        if not contain then
            return fit(file, cells, opts)
        end
        local pixels = opts and opts.info and opts.info.size or util.dim(file)
        local cell = snacks.image.terminal.size()
        local ratio = (pixels.width / pixels.height) * (cell.cell_height / cell.cell_width)
        -- leave room for the border around the image
        local room = 2 * border_size
        return contain_cells(ratio, math.max(1, cells.width - room), math.max(1, cells.height - room))
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
local function reshow_images(snacks)
    local placement = snacks.image.placement

    local state = placement.state

    placement.state = function(self, ...)
        if vim.bo[self.buf].filetype == "image" and self.hidden and #self:wins() > 0 then
            self.hidden = false
        end
        return state(self, ...)
    end
end

-- Draw a square border around image buffers. Snacks renders the first image row over the
-- buffer's only line and the remaining rows as virtual lines below it, so the top border takes
-- the place of that first row and everything else moves down into the virtual lines.
local function border_images(snacks)
    local placement = snacks.image.placement

    local render = placement._render

    placement._render = function(self, extmarks)
        local first, rest = extmarks[1], extmarks[2]
        if vim.bo[self.buf].filetype == "image" and #extmarks == 2 and first.virt_text and rest.virt_lines then
            local hl = "FloatBorder"
            local bar = { ("│"):rep(border_size), hl }
            local function row(cells)
                return { { "" }, bar, cells, bar }
            end
            local width = self._state.loc.width
            local lines = { row(first.virt_text[1]) }
            for _, line in ipairs(rest.virt_lines) do
                lines[#lines + 1] = row(line[2])
            end
            lines[#lines + 1] = { { "└" .. ("─"):rep(width) .. "┘", hl } }
            first.virt_text = { { "┌" .. ("─"):rep(width) .. "┐", hl } }
            rest.virt_lines = lines
        end
        return render(self, extmarks)
    end
end

---@param snacks table the loaded snacks module
function M.setup(snacks)
    contain_images(snacks)
    reshow_images(snacks)
    border_images(snacks)
end

return M
