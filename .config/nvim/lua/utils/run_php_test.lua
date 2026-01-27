return function()
  vim.cmd("!php artisan test " .. vim.fn.expand("%:."))
end
