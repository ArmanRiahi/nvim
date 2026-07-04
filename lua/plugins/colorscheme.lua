return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        config = function()
            vim.cmd.colorscheme "catppuccin"
        end,

    },

    -- {
    --     "Tsuzat/NeoSolarized.nvim",
    --     lazy = false,
    --     priority = 1000,
    --     config = function()
    --         vim.cmd[[colorscheme NeoSolarized]]
    --     end,
    -- },

    -- {
    --     "Mofiqul/dracula.nvim",
    --     lazy = false,
    --     priority = 1000,
    --     config = function()
    --         -- Make sure to set the color scheme when neovim loads and configures the dracula plugin
    --         vim.cmd.colorscheme "dracula"
    --     end
    -- },
}
