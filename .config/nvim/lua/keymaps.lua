local map = vim.keymap.set

-- keymaps set elsewhere, listed here so every keymap can be found in this file
--
-- window navigation (vim-tmux-navigator defaults), crosses into tmux panes at the edge of nvim:
--   <C-h> / <C-j> / <C-k> / <C-l>   move to the window or tmux pane left / below / above / right (also in terminals)
--   <C-\>                           go back to the previous window or tmux pane
--
-- completion menu, insert and command mode (plugins/cmp.lua, they must be passed to cmp.setup):
--   <M-n> / <M-p>   select the next / previous item
--   <M-y>           confirm the selected item (the first one when none is selected)
--   <M-j> / <M-k>   jump to the next / previous snippet placeholder (insert and select mode)
--
-- telescope prompt, insert mode (plugins/telescope.lua, they must be passed to telescope.setup):
--   <esc>              close the picker
--   <M-n> / <M-p>      move the selection down / up
--   <M-y>              open the selected entry
--   <C-Down> / <C-Up>  next / previous prompt from history
--   grep files (<leader>g / <leader>G) only:
--   <C-k>              wrap the prompt in quotes, to add rg flags after it (e.g. "foo" -t lua)
--   <C-space>          fuzzy filter the current results
--   telescope defaults, also in every picker:
--   <C-n> / <C-p> or <Down> / <Up>   move the selection   <CR> open   <C-c> close
--   <C-x> / <C-v> / <C-t>            open in a split / vsplit / new tab
--   <C-u> / <C-d>                    scroll the preview up / down   <PageUp> / <PageDown> scroll the results
--   <Tab> / <S-Tab>                  select entries for a multi-open   <C-q> / <M-q> send all / selected to quickfix
--   <C-r><C-w>                       insert the word that was under the cursor   <C-/> list the picker's keys
--
-- image viewer, in a buffer showing an image (lib/image.lua, set when the image is opened):
--   <ScrollWheelUp> / <ScrollWheelDown>   zoom in / out on the image under the mouse, scroll elsewhere
--   + / _                                 zoom in / out
--   h / j / k / l                         move around the zoomed image
--   <LeftMouse> + <LeftDrag>              drag the zoomed image
--   r                                     reset zoom and position
--
-- file tree, inside the neo-tree window (neo-tree defaults, plugins/neo-tree.lua sets none; ? lists them all):
--   open:      <cr> / <2-LeftMouse> open   s vsplit   S split   t new tab   w pick a window
--   preview:   P toggle preview   l focus preview   <C-f> / <C-b> scroll preview   <esc> close preview
--   folders:   <space> toggle   C close   z close all   <bs> go up a folder   . make it the root
--   files:     a add (end with / for a folder)   A add folder   d delete   r rename   b rename without extension
--              c copy   m move   y copy to clipboard   x cut to clipboard   p paste   <C-r> clear clipboard
--   find:      / fuzzy find   D fuzzy find folders   # fuzzy sort   f filter   <C-x> clear filter
--              (in the find prompt: <C-n> / <C-p> or <down> / <up> move, <esc> close)
--   view:      H toggle hidden files   i file details   [g / ]g prev / next git change   R refresh
--              o then c / d / g / m / n / s / t order by created, diagnostics, git, modified, name, size, type
--   window:    e toggle auto width   < / > previous / next source   q close   ? help
--
-- search and replace panel (spectre defaults, <leader>s / <leader>S open it; these only apply inside the panel):
--   <Tab> / <S-Tab>       next / previous input (search, replace, path)
--   <cr>                  open the file of the result under the cursor
--   dd                    exclude / include the result under the cursor
--   <leader>rc            replace the result under the cursor   <leader>R replace all
--   <leader>q             send all results to quickfix   <leader>l repeat the last search
--   ti / th               toggle ignore case / search hidden files   <leader>o show options
--
-- debugger panels (dap-ui defaults, in the scopes, watches, stacks and breakpoints windows):
--   <cr> / <2-LeftMouse>  expand / collapse   o open (jump to the frame or breakpoint)   e edit a value or watch
--   d remove   t toggle (breakpoint, or subtle frames)   r send to the repl
--
-- package manager window (mason defaults, :Mason):
--   i install   u update   U update all   X uninstall   c / C check for a new version / all outdated
--   <CR> expand the package   g? help
--
-- insert mode (nvim-autopairs defaults):
--   typing an opening bracket or quote inserts the closing one, <CR> between a pair opens an indented line
--   and <BS> on an empty pair deletes both

-- general
map("n", "q", "<nop>", { desc = "disable macro recording" })
map("n", "<esc>", "<cmd>nohlsearch<cr>", { desc = "clear search highlighting" })
map("x", "p", "P", { desc = "paste without yanking selected text" })

-- git (lazygit, gitsigns)
local git = require "lib.git"

map("n", "<leader>L", git.lazygit, { desc = "open lazygit window (lazygit)" })
map("n", "]h", git.next_hunk, { desc = "navigate to the next git hunk (gitsigns)" })
map("n", "[h", git.prev_hunk, { desc = "navigate to the previous git hunk (gitsigns)" })
map("n", "]H", git.next_staged_hunk, { desc = "navigate to the next staged git hunk (gitsigns)" })
map("n", "[H", git.prev_staged_hunk, { desc = "navigate to the previous staged git hunk (gitsigns)" })

-- buffers (bufferline)
local buffer = require "lib.buffer"

map("n", "<S-h>", buffer.prev, { desc = "prev buffer (bufferline)" })
map("n", "<S-l>", buffer.next, { desc = "next buffer (bufferline)" })
map("n", "l", buffer.open_last_file, { desc = "open last file or move right" })
map("n", "<leader>q", buffer.close_terminals_or_others, { desc = "close terminals or other buffers (bufferline)" })
map("n", "<leader>k", buffer.close_current, { desc = "close (kill) current buffer (bufferline)" })
map("n", "<leader>ch", buffer.close_left, { desc = "delete buffers to the left (bufferline)" })
map("n", "<leader>cl", buffer.close_right, { desc = "delete buffers to the right (bufferline)" })

-- file tree (neo-tree)
local tree = require "lib.tree"

map("n", "<leader>e", tree.focus, { desc = "focus file tree (neo-tree)" })
map("n", "<leader>p", tree.close, { desc = "close file tree (neo-tree)" })

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

-- copy file path or name
local copy = require "lib.copy"

map("n", "<leader>cp", copy.path, { desc = "copy current file relative path" })
map("n", "<leader>ca", copy.abs_path, { desc = "copy current file absolute path" })
map("n", "<leader>cf", copy.name, { desc = "copy current file name with extension" })

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

        map("n", "gd", lsp.definition, opts "go to definition (lspconfig)")
        map("n", "gD", lsp.declaration, opts "go to declaration (lspconfig)")
        map("n", "gi", lsp.implementation, opts "go to implementation (lspconfig)")
        -- nowait: don't wait to see if this is one of the built-in grn / gra / grr / gri lsp keymaps
        map("n", "gr", lsp.references, vim.tbl_extend("force", opts "go to references (lspconfig)", { nowait = true }))

        map("n", "K", lsp.hover, opts "show hover documentation (lspconfig)")
        map("n", "gK", lsp.signature_help, opts "signature help (lspconfig)")
        map("n", "<leader>a", lsp.code_action, opts "code actions (lspconfig)")
        map("n", "<leader>r", lsp.rename, opts "rename symbol (lspconfig)")

        map("n", "<leader>d", lsp.diagnostic_float, opts "show hover diagnostics (lspconfig)")
        map("n", "[d", lsp.prev_diagnostic, opts "go to prev diagnostic (lspconfig)")
        map("n", "]d", lsp.next_diagnostic, opts "go to next diagnostic (lspconfig)")

        map("n", "<leader>xs", lsp.start, opts "start lsp server (lspconfig)")
        map(
            "n",
            "<leader>xS",
            lsp.stop,
            opts "stop lsp servers for this buffer (lspconfig)"
        )
        map("n", "<leader>xr", lsp.restart, opts "restart lsp server (lspconfig)")
    end,
})

-- debugging (dap)
local dap = require "lib.dap"

-- session
map("n", "<leader>bp", dap.continue, { desc = " start or continue debugging (dap)" })
map("n", "<leader>bP", dap.pause, { desc = " pause debugging (dap)" })
map("n", "<leader>bl", dap.run_last, { desc = " run last debug session again (dap)" })
map("n", "<leader>br", dap.run_to_cursor, { desc = "run to cursor (dap)" })
map("n", "<leader>bt", dap.debug_go_test, { desc = "debug nearest go test (dap-go)" })

-- stepping
map("n", "<leader>bi", dap.step_into, { desc = " step into (dap)" })
map("n", "<leader>bo", dap.step_over, { desc = " step over (dap)" })
map("n", "<leader>bO", dap.step_out, { desc = " step out (dap)" })
map("n", "<leader>bB", dap.step_back, { desc = " step back (dap)" })
map("n", "<leader>bR", dap.reverse_continue, { desc = "reverse continue to the previous breakpoint (dap-rr)" })

-- stopping
map("n", "<leader>bq", dap.terminate, { desc = " stop debugging (dap)" })
map("n", "<leader>bQ", dap.close, { desc = "stop debugging and close the debugger ui (dap)" })
map("n", "<leader>bd", dap.disconnect, { desc = " disconnect from debug session (dap)" })

-- breakpoints
map("n", "<leader>bb", dap.toggle_breakpoint, { desc = "toggle breakpoint (dap)" })
map("n", "<leader>bc", dap.conditional_breakpoint, { desc = "set conditional breakpoint (dap)" })
map("n", "<leader>bx", dap.clear_breakpoints, { desc = "clear all breakpoints (dap)" })
map("n", "<LeftMouse>", dap.click_breakpoint, { expr = true, desc = "click the margin to toggle a breakpoint (dap)" })

-- ui
map("n", "<leader>bu", dap.toggle_ui, { desc = "toggle debugger ui (dap-ui)" })
map({ "n", "v" }, "<leader>be", dap.eval, { desc = "evaluate expression under cursor (dap-ui)" })
map({ "n", "i", "v" }, "<MouseMove>", dap.hover_controls, { desc = "debugger toolbar tooltips (dap-ui)" })

-- discoverability (which-key)
local which_key = require "lib.which_key"

map("n", "<leader>?", which_key.show_buffer_local, { desc = "buffer local keymaps (which-key)" })
