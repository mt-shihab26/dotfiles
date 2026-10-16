local map = vim.keymap.set

-- keymaps set elsewhere, listed here so every keymap can be found in this file
--
-- window navigation (vim-tmux-navigator defaults), crosses into tmux panes at the edge of nvim:
--   <C-h> / <C-j> / <C-k> / <C-l>   move to the window or tmux pane left / below / above / right
--
-- completion menu, insert and command mode (plugins/cmp.lua, they must be passed to cmp.setup):
--   <M-n> / <M-p>   select the next / previous item
--   <M-y>           confirm the selected item (the first one when none is selected)
--
-- telescope prompt, insert mode (plugins/telescope.lua, they must be passed to telescope.setup):
--   <esc>              close the picker
--   <M-n> / <M-p>      move the selection down / up
--   <M-y>              open the selected entry
--   <C-Down> / <C-Up>  next / previous prompt from history
--   grep files (<leader>g / <leader>G) only:
--   <C-k>              wrap the prompt in quotes, to add rg flags after it (e.g. "foo" -t lua)
--   <C-space>          fuzzy filter the current results
--
-- image viewer, in a buffer showing an image (lib/image.lua, set when the image is opened):
--   <ScrollWheelUp> / <ScrollWheelDown>   zoom in / out on the image under the mouse, scroll elsewhere
--   + / _                                 zoom in / out
--   h / j / k / l                         move around the zoomed image
--   <LeftMouse> + <LeftDrag>              drag the zoomed image
--   r                                     reset zoom and position

-- general
map("n", "q", "<nop>", { desc = "disable macro recording" })
map("n", "<esc>", "<cmd>nohlsearch<cr>", { desc = "clear search highlighting" })
map("x", "p", "P", { desc = "paste without yanking selected text" })

-- buffers (bufferline)
local buffer = require "lib.buffer"

map("n", "<S-h>", "<cmd>BufferLineCyclePrev<cr>", { desc = "prev buffer (bufferline)" })
map("n", "<S-l>", "<cmd>BufferLineCycleNext<cr>", { desc = "next buffer (bufferline)" })
map("n", "l", buffer.open_last_file, { desc = "open last file or move right" })
map("n", "<leader>q", buffer.close_terminals_or_others, { desc = "close terminals or other buffers (bufferline)" })
map("n", "<leader>k", "<cmd>bp<bar>sp<bar>bn<bar>bd<cr>", { desc = "close (kill) current buffer (bufferline)" })
map("n", "<leader>ch", "<cmd>BufferLineCloseLeft<cr>", { desc = "delete buffers to the left (bufferline)" })
map("n", "<leader>cl", "<cmd>BufferLineCloseRight<cr>", { desc = "delete buffers to the right (bufferline)" })

-- file tree (neo-tree)
map("n", "<leader>e", "<cmd>Neotree action=focus<cr>", { desc = "focus file tree (neo-tree)", remap = true })
map("n", "<leader>p", "<cmd>Neotree action=close<cr>", { desc = "close file tree (neo-tree)", remap = true })

-- git (lazygit, gitsigns)
map("n", "<leader>L", "<cmd>LazyGit<cr>", { desc = "open lazygit window (lazygit)", remap = true })
map("n", "]h", "<cmd>silent Gitsigns next_hunk<cr>", { desc = "navigate to the next git hunk (gitsigns)" })
map("n", "[h", "<cmd>silent Gitsigns prev_hunk<cr>", { desc = "navigate to the previous git hunk (gitsigns)" })
map("n", "]H", "<cmd>silent Gitsigns nav_hunk next target=staged<cr>",
    { desc = "navigate to the next staged git hunk (gitsigns)" })
map("n", "[H", "<cmd>silent Gitsigns nav_hunk prev target=staged<cr>",
    { desc = "navigate to the previous staged git hunk (gitsigns)" })

-- fuzzy finding (telescope)
local telescope = require "lib.telescope"

map("n", "<leader>f", telescope.find_files, { desc = "find files (telescope)" })
map("n", "<leader>F", telescope.find_all_files, { desc = "find all files (telescope)" })
map("n", "<leader>g", telescope.grep_files, { desc = "grep files (telescope)" })
map("n", "<leader>G", telescope.grep_all_files, { desc = "grep all files (telescope)" })
map("n", "<leader>h", telescope.help_tags, { desc = "help tags (telescope)" })
map("n", "<leader>H", telescope.lsp_document_symbols, { desc = "lsp document symbols (telescope)" })

-- search and replace (spectre)
local spectre = require "lib.spectre"

map("n", "<leader>s", spectre.search_buffer, { desc = "search on current buffer (spectre)" })
map("n", "<leader>S", spectre.search_word, { desc = "search on multi buffers (spectre)" })
map("v", "<leader>S", spectre.search_selection, { desc = "search on multi buffers (spectre)" })

-- clipboard
local clipboard = require "lib.clipboard"

map("n", "<leader>cp", clipboard.path, { desc = "copy current file relative path" })
map("n", "<leader>ca", clipboard.abs_path, { desc = "copy current file absolute path" })
map("n", "<leader>cf", clipboard.name, { desc = "copy current file name with extension" })

-- toggle
local toggle = require "lib.toggle"

map("n", "<leader>tc", toggle.completion, { desc = "toggle completion (cmp)" })
map("n", "<leader>tf", toggle.format_on_save, { desc = "toggle format on save" })
map("n", "<leader>ti", toggle.indent_char, { desc = "toggle tabs/spaces for indentation" })
map("n", "<leader>tm", toggle.markdown_render, { desc = "toggle markdown rendering (render-markdown)" })
map("n", "<leader>ts", toggle.semantic_tokens, { desc = "toggle lsp semantic tokens highlighting" })
map("n", "<leader>tw", toggle.wrap, { desc = "toggle line wrapping on/off" })

-- text case conversion
local case = require "lib.case"

map("v", "<leader>uu", case.visual "upper", { desc = "convert selection to UPPERCASE" })
map("v", "<leader>ul", case.visual "lower", { desc = "convert selection to lowercase" })
map("v", "<leader>uc", case.visual "capitalize", { desc = "convert selection to Capitalize Each Word" })
map("v", "<leader>um", case.visual "camel", { desc = "convert selection to helloWorld" })
map("v", "<leader>up", case.visual "pascal", { desc = "convert selection to HelloWorld" })
map("v", "<leader>us", case.visual "snake", { desc = "convert selection to hello_world" })
map("v", "<leader>uS", case.visual "constant", { desc = "convert selection to HELLO_WORLD" })
map("v", "<leader>uk", case.visual "kebab", { desc = "convert selection to hello-world" })
map("v", "<leader>ud", case.visual "dot", { desc = "convert selection to hello.world" })
map("v", "<leader>uw", case.visual "space", { desc = "convert selection to hello world" })

-- lsp (lspconfig), set in each buffer a language server attaches to
local lsp = require "lib.lsp"

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local opts = function(desc)
            return { buffer = args.buf, noremap = true, silent = true, desc = desc }
        end
        local buf = vim.lsp.buf
        local diagnostic = vim.diagnostic

        map("n", "gd", buf.definition, opts "go to definition (lspconfig)")
        map("n", "gD", buf.declaration, opts "go to declaration (lspconfig)")
        map("n", "gi", buf.implementation, opts "go to implementation (lspconfig)")
        map("n", "gr", buf.references, opts "go to references (lspconfig)")

        map("n", "K", buf.hover, opts "show hover documentation (lspconfig)")
        map("n", "gK", buf.signature_help, opts "signature help (lspconfig)")
        map("n", "<leader>a", buf.code_action, opts "code actions (lspconfig)")
        map("n", "<leader>r", buf.rename, opts "rename symbol (lspconfig)")

        map("n", "<leader>d", diagnostic.open_float, opts "show hover diagnostics (lspconfig)")
        map("n", "[d", function() diagnostic.jump { count = -1, float = true } end,
            opts "go to prev diagnostic (lspconfig)")
        map("n", "]d", function() diagnostic.jump { count = 1, float = true } end,
            opts "go to next diagnostic (lspconfig)")

        map("n", "<leader>xs", lsp.start, opts "start lsp server (lspconfig)")
        map("n", "<leader>xS", lsp.stop, opts "stop lsp server (lspconfig)")
        map("n", "<leader>xr", lsp.restart, opts "restart lsp server (lspconfig)")
    end,
})

-- debugging (dap)
local dap = require "lib.dap"

-- session
map("n", "<leader>bp", dap.continue, { desc = " start or continue debugging (dap)" })
map("n", "<leader>bP", "<cmd>DapPause<cr>", { desc = " pause debugging (dap)" })
map("n", "<leader>bl", dap.run_last, { desc = " run last debug session again (dap)" })
map("n", "<leader>br", dap.run_to_cursor, { desc = "run to cursor (dap)" })
map("n", "<leader>bt", dap.debug_go_test, { desc = "debug nearest go test (dap-go)" })

-- stepping
map("n", "<leader>bi", "<cmd>DapStepInto<cr>", { desc = " step into (dap)" })
map("n", "<leader>bo", "<cmd>DapStepOver<cr>", { desc = " step over (dap)" })
map("n", "<leader>bO", "<cmd>DapStepOut<cr>", { desc = " step out (dap)" })
map("n", "<leader>bB", dap.step_back, { desc = " step back (dap)" })

-- stopping
map("n", "<leader>bq", "<cmd>DapTerminate<cr>", { desc = " stop debugging (dap)" })
map("n", "<leader>bQ", dap.close, { desc = "stop debugging and close the debugger ui (dap)" })
map("n", "<leader>bd", "<cmd>DapDisconnect<cr>", { desc = " disconnect from debug session (dap)" })

-- breakpoints
map("n", "<leader>bb", "<cmd>DapToggleBreakpoint<cr>", { desc = "toggle breakpoint (dap)" })
map("n", "<leader>bc", dap.conditional_breakpoint, { desc = "set conditional breakpoint (dap)" })
map("n", "<leader>bx", "<cmd>DapClearBreakpoints<cr>", { desc = "clear all breakpoints (dap)" })
map("n", "<LeftMouse>", dap.click_breakpoint, { expr = true, desc = "click the margin to toggle a breakpoint (dap)" })

-- ui
map("n", "<leader>bu", dap.toggle_ui, { desc = "toggle debugger ui (dap-ui)" })
map({ "n", "v" }, "<leader>be", dap.eval, { desc = "evaluate expression under cursor (dap-ui)" })
map({ "n", "i", "v" }, "<MouseMove>", dap.hover_controls,
    { desc = "show what a debugger toolbar button does on hover (dap-ui)" })

-- discoverability (which-key)
local which_key = require "lib.which_key"

map("n", "<leader>?", which_key.show_buffer_local, { desc = "buffer local keymaps (which-key)" })
