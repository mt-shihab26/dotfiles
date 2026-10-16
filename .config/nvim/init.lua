vim.loader.enable() -- cache compiled lua modules, so requiring them at startup skips parsing and searching

require "options"
require "plugins"
require "commands"
require "autocmds"
require "keymaps"
