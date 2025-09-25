return {
    settings = {
        Lua = {
            runtime = { version = 'Lua 5.1' },
            diagnostics = { globals = { 'vim' } },
            workspace = { library = vim.api.nvim_get_runtime_file("", true), checkThirdParty = false },
            telemetry = { enable = false },
        },
    },
}
