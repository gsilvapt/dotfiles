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
            }})

        end,
    },
}


