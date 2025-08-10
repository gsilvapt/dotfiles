return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            {
                "folke/lazydev.nvim",
                opts = {
                    library= {
                        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                    },
                },
            },
        },
        config = function()
            local lspconfig = require("lspconfig")
            -- Lua LSP config for better write neovim configs
            lspconfig.lua_ls.setup({
                settings = {
                    Lua = {
                        runtime = { version = 'Lua 5.1' },
                        diagnostics = { globals = { 'vim' } },
                        workspace = { library = vim.api.nvim_get_runtime_file("", true), checkThirdParty = false },
                        telemetry = { enable = false },
                    },
                },
            })

            -- Python LSP Configuration
            lspconfig.pyright.setup({
                flags = {
                    debounce_text_changes = 150,
                },
                settings = {
                    python = {
                        analysis = {
                            typeCheckingMode = "basic",
                            autoSearchPOaths = true,
                            useLibraryCodeForTypes = true,
                            diagnosticMode = "workspace",
                        },
                    },
                },
            })

            -- Go LSP Configuration
            lspconfig.gopls.setup({
                settings = {
                    gopls = {
                        analyses = {
                            unusedparams = true,
                        },
                        staticcheck = true,
                        gofumpt = true,
                    },
                },
            })
            vim.api.nvim_create_autocmd({"BufWritePre"}, {
                pattern = {"*.go"},
                callback = function()
                   local params = vim.lsp.util.make_range_params()
                    params.context = {only = {"source.organizeImports"}}
                    -- buf_request_sync defaults to a 1000ms timeout. Depending on your
                    -- machine and codebase, you may want longer. Add an additional
                    -- argument after params if you find that you have to write the file
                    -- twice for changes to be saved.
                    -- E.g., vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 3000)
                    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params)
                    for cid, res in pairs(result or {}) do
                        for _, r in pairs(res.result or {}) do
                            if r.edit then
                                local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
                                vim.lsp.util.apply_workspace_edit(r.edit, enc)
                            end
                        end
                    end
                    vim.lsp.buf.format({async = false})
                end,
            })

            lspconfig.terraformls.setup({})
            vim.api.nvim_create_autocmd({"BufWritePre"}, {
                pattern = {"*.tf", "*.tfvars"},
                callback = function()
                    vim.lsp.buf.format()
                end,
            })

            lspconfig.rust_analyzer.setup({
                settings = {
                    ['rust-analyzer'] = {
                        diagnostics = {
                            enable = false;
                        }
                    }
                }
            })
            lspconfig.eslint.setup({})
            lspconfig.tsp_server.setup({
                settings = {
                    bit
                },
            })

            vim.lsp.enable("ts_ls")
        end
    },
}


