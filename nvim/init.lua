require("gsilvapt")

-- Options
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

-- Custom key bindings for movement/shortcuts
vim.g.mapleader = "\\"

vim.keymap.set("n", "<C-h>", "<C-W>h", { noremap=true})
vim.keymap.set("n", "<C-j>", "<C-W>j", { noremap=true})
vim.keymap.set("n", "<C-k>", "<C-W>k", { noremap=true})
vim.keymap.set("n", "<C-l>", "<C-W>l", { noremap=true})

vim.keymap.set("n", "<C-n>", vim.cmd.Ex)
vim.keymap.set("n", "<Leader>bp", vim.cmd.bp)
vim.keymap.set("n", "<Leader>bn", vim.cmd.bn)
vim.keymap.set("n", "<Leader>bd", vim.cmd.bd)

-- Custom key bindings for LSP
local opts = { noremap=true, silent=true }
vim.keymap.set("n", "<Leader>gd", vim.lsp.buf.definition, opts)
vim.keymap.set("n", "<Leader>gr", vim.lsp.buf.code_action, opts)
vim.keymap.set("n", "<Leader>rs", vim.lsp.buf.rename, opts)

