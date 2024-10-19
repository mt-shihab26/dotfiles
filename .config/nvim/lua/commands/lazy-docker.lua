-- lazy docker

local lazydocker = require("toggleterm.terminal").Terminal:new {
    cmd = "lazydocker",
    direction = "float",
    float_opts = { border = "curved" },
    -- function to run on opening the terminal
    on_open = function(term)
        vim.cmd "startinsert!"
        vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
    end,
    on_close = function()
        vim.cmd "startinsert!"
    end,
}

vim.api.nvim_create_user_command("LazyDocker", function()
    lazydocker:toggle()
end, {})
