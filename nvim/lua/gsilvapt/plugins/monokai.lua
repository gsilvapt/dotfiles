return {
    'tanvirtin/monokai.nvim',
    config = function()
        local palette = require('monokai').classic
        require('monokai').setup {
            palette = {
                diff_text = '#133337',
            },
            custom_hlgroups = {
                TSInclude = {
                    fg = palette.aqua,
                },
                GitSignsAdd = {
                    fg = palette.green,
                    bg = palette.base2
                },
                GitSignsDelete = {
                    fg = palette.pink,
                    bg = palette.base2
                },
                GitSignsChange = {
                    fg = palette.orange,
                    bg = palette.base2
                },
            },
            italics = true,
        }
    end
}
