return {
    "gsilvapt/neotrees.nvim",
    version = "v0.0.3",
    keys = {
        { "<leader>gw", function() require("neotrees").open() end, desc = "Git worktrees" },
    },
    after_create = function(path,branch)
        if not path:find("github.com/runreveal", 1, true) then
            return
        end

        -- RunReveal specific instructions
        -- Copy .env from the repo root (the main worktree)
        local git = require("neotrees.git")
        local main_path = git.current_worktree_path() -- or hard-code your main checkout path
        vim.system({ "cp", main_path .. "/.env", path .. "/.env" }):wait()
        -- Run pnpm i in a subdirectory (adjust "apps/web" to your target dir)
        local subdir = path .. "/app"
        vim.system({ "pnpm", "i" }, { cwd = subdir }):wait()
    end,
    opts = {},
}
