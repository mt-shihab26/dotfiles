-- File type detection for .env and .env.example files
vim.cmd [[
  augroup dotenv
    autocmd!
    autocmd BufNewFile,BufRead .env,.env.* setfiletype sh
    autocmd BufNewFile,BufRead .env.example setfiletype sh
  augroup END
]]
