return {
    "numToStr/Comment.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "JoosepAlviste/nvim-ts-context-commentstring",
    },
    config = function()
        -- 1. Setup the context-aware string provider
        require('ts_context_commentstring').setup({
            enable_autocmd = false,
        })

        local comment = require("Comment")
        local ts_integration = require("ts_context_commentstring.integrations.comment_nvim")

        -- 2. Setup Comment.nvim
        comment.setup({
            pre_hook = ts_integration.create_pre_hook(),
        })

        -- 3. Keymaps
        -- Note: If <C-/> doesn't work, use <C-_>
        local opts = { noremap = true, silent = true }

        -- Normal Mode: Toggle current line
        vim.keymap.set("n", "<C-/>", "gcc", { remap = true, desc = "Comment Line" })
        vim.keymap.set("n", "<C-_>", "gcc", { remap = true, desc = "Comment Line" })

        -- Visual Mode: Toggle selection
        vim.keymap.set("x", "<C-/>", "gc", { remap = true, desc = "Comment Selection" })
        vim.keymap.set("x", "<C-_>", "gc", { remap = true, desc = "Comment Selection" })
    end,
}
