return {
    'nvim-telescope/telescope.nvim',
    version = '0.2.1',
    dependencies = {
        {'nvim-lua/plenary.nvim'},
        {'nvim-telescope/telescope-live-grep-args.nvim', version = '*'},
    },

    config = function()
        local telescope = require("telescope")
        local actions = require "telescope.actions"
        telescope.setup({
            defaults = {
                mappings = {
                    n = {
                        ["<C-w>"] = actions.send_selected_to_qflist + actions.open_qflist,
                    },
                },
            },
            pickers = {
                find_files = {
                    find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
                }
            },
        })
        telescope.load_extension("live_grep_args")

        local builtin = require("telescope.builtin")
        vim.keymap.set("n", "<C-p>", builtin.find_files, { desc = "Telescope find files" })
        vim.keymap.set("n", "<Leader>fg", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>")
        vim.keymap.set("n", "<Leader>fb", builtin.buffers, { desc = "Telescope search buffers" })
        vim.keymap.set("n", "<Leader>fs", builtin.lsp_document_symbols, { desc = "Telescope find document symbols" })
    end,
}
