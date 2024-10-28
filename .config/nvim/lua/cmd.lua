-- file type detection for .env and .env.* files
vim.cmd "augroup dotenv | autocmd! | autocmd BufNewFile,BufRead .env,.env.* setfiletype sh | augroup END"
