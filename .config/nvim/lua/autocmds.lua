-- :wa writes all buffers without formatting them (see lib/toggle.lua)
vim.cmd [[cnoreabbrev <expr> wa (getcmdtype() == ':' && getcmdline() == 'wa') ? 'lua require("lib.toggle").write_all_no_format()' : 'wa']]

-- highlight yanked text briefly
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.hl.on_yank()
    end,
})

-- custom filetype detection
local filetype = require "lib.filetype"
filetype.mdx()
filetype.gitconfig()
filetype.glsl()
