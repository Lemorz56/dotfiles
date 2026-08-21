Snacks = Snacks

return {
    "folke/snacks.nvim",
    ---@type snacks.Config
    opts = {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
        -- indent = { enabled = true, only_scope = true },
        scroll = { enabled = true },
        keys = {
            { "<leader>z", function() Snacks.zen() end, desc = "Toggle Zen Mode" },
            { "<leader>Z", function() Snacks.zen.zoom() end, desc = "Toggle Zen Mode" }
        }
    },
}
