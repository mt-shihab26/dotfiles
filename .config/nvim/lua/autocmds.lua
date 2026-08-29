-- disable format on save before :wa, so writing all buffers doesn't reformat everything at once
vim.cmd [[cnoreabbrev <expr> wa (getcmdtype() == ':' && getcmdline() == 'wa') ? 'FormatDisable <Bar> wa' : 'wa']]
