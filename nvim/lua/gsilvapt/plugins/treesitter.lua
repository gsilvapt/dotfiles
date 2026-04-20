return {
  'nvim-treesitter/nvim-treesitter',
  branch = 'main',
  lazy = false,
  build = ':TSUpdate',
  config = function()
      require('nvim-treesitter').install { "c", "go", "typescript", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline" }
  end
}
