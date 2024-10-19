-- Treesitter

return {
    "nvim-treesitter/nvim-treesitter",
    opts = {
        auto_install = true,
        ensure_installed = {
            "php_only",
            "twig",
            "markdown",
            "markdown_inline",
            "templ",
        },
    },
    config = function()
        local function blade_parser()
            vim.filetype.add {
                pattern = {
                    [".*%.blade%.php"] = "blade",
                },
            }

            local augroup = vim.api.nvim_create_augroup("lsp_blade_workaround", { clear = true })

            vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
                group = augroup,
                pattern = "*.blade.php",
                callback = function()
                    vim.bo.filetype = "php"
                end,
            })

            require("nvim-treesitter.parsers").get_parser_configs().blade = {
                install_info = {
                    url = "https://github.com/EmranMR/tree-sitter-blade",
                    files = {
                        "src/parser.c",
                    },
                    branch = "main",
                },
                filetype = "blade",
            }

            -- Additional autocommand to switch back to 'blade' after LSP has attached
            vim.api.nvim_create_autocmd("LspAttach", {
                pattern = "*.blade.php",
                callback = function(args)
                    vim.schedule(function()
                        -- Check if the attached client is 'intelephense'
                        for _, client in ipairs(vim.lsp.get_active_clients()) do
                            if client.name == "intelephense" and client.attached_buffers[args.buf] then
                                vim.api.nvim_buf_set_option(args.buf, "filetype", "blade")
                                -- update treesitter parser to blade
                                vim.api.nvim_buf_set_option(args.buf, "syntax", "blade")
                                break
                            end
                        end
                    end)
                end,
            })
        end

        blade_parser()

        -- make $ part of the keyword for php.
        vim.api.nvim_exec([[autocmd FileType php set iskeyword+=$]], false)
    end,
}
