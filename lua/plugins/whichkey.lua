return {
    'folke/which-key.nvim',
    event = 'VimEnter',
    config = function()
        local which_key = require('which-key')

        -- Call setup with default configuration
        which_key.setup()

        -- Modern v3 Spec: Use flat list structure with explicit 'group' names
        which_key.add({
            { "<leader>/", group = "Comments" },
            { "<leader>c", group = "[C]ode" },
            { "<leader>d", group = "[D]ebug" },
            { "<leader>e", group = "[E]xplorer" },
            { "<leader>f", group = "[F]ind" },
            { "<leader>g", group = "[G]it" },
            { "<leader>J", group = "[J]ava" },
            { "<leader>w", group = "[W]indow" }
        })
    end
}
