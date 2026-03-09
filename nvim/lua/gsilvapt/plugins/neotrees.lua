return {
    "gsilvapt/neotrees.nvim",
    version = "v0.0.*",
    keys = {
        { "<leader>gw", function() require("worktree").open() end, desc = "Git worktrees" },
    },
    opts = {},
}
