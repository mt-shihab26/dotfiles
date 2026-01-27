return function()
  vim.cmd("split | terminal php artisan test " .. vim.fn.expand("%:."))
end
