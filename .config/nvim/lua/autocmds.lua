vim.cmd [[cnoreabbrev <expr> wa (getcmdtype() == ':' && getcmdline() == 'wa') ? 'lua require("lib.toggle").write_all_no_format()' : 'wa']]
