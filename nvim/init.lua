require("gsilvapt")

-- Options
vim.bo.omnifunc = 'v:lua.vim.lsp.omnifunc'
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.linebreak = true
vim.opt.swapfile = false
vim.opt.smartindent = true
vim.opt.smarttab = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.colorcolumn = "120"
-- Modify tabs for JS/TS/HTML files
vim.api.nvim_create_autocmd("FileType", {
    pattern = {"*.tsx", "*.js", "*.html"},
    callback = function()
        vim.opt.tabstop = 2
        vim.opt.softtabstop = 2
        vim.opt.shiftwidth = 2
    end
})


-- Custom key bindings for movement/shortcuts
vim.g.mapleader = "\\"
vim.api.nvim_set_option_value("clipboard", "unnamed", {})

vim.keymap.set("n", "<C-h>", "<C-W>h", { noremap=true})
vim.keymap.set("n", "<C-j>", "<C-W>j", { noremap=true})
vim.keymap.set("n", "<C-k>", "<C-W>k", { noremap=true})
vim.keymap.set("n", "<C-l>", "<C-W>l", { noremap=true})

vim.keymap.set("n", "<C-n>", vim.cmd.Ex)
vim.keymap.set("n", "<Leader>bp", vim.cmd.bp)
vim.keymap.set("n", "<Leader>bn", vim.cmd.bn)
vim.keymap.set("n", "<Leader>bd", vim.cmd.bd)
vim.keymap.set({"n", "v"}, "<Leader>Y", '"+y')

-- Custom key bindings for LSP
local opts = { noremap=true, silent=true }
vim.keymap.set("n", "<Leader>gd", vim.lsp.buf.definition, opts)
vim.keymap.set("n", "<Leader>gr", vim.lsp.buf.references, opts)
vim.keymap.set("n", "<Leader>ga", vim.lsp.buf.code_action, opts)
vim.keymap.set("n", "<Leader>rs", vim.lsp.buf.rename, opts)

vim.keymap.set("n", "<Leader>dn", vim.diagnostic.goto_next, opts)
vim.keymap.set("n", "<Leader>dp", vim.diagnostic.goto_prev, opts)

vim.keymap.set('n', '<leader>cc', '<cmd>ClaudeCode<CR>', { desc = 'Toggle Claude Code' })

vim.cmd.colorscheme 'solarized-osaka'
vim.opt.background = 'dark'
vim.cmd.foldmethod = 'syntax'
