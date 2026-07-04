-- none ls

return {
    "nvimtools/none-ls.nvim",
    config = function()
        local null_ls = require("null-ls")

        null_ls.setup({
            sources = {
                -- # formatting #
                null_ls.builtins.formatting.stylua,
                null_ls.builtins.formatting.clang_format,
                null_ls.builtins.formatting.black,
                null_ls.builtins.formatting.prettier,
                null_ls.builtins.formatting.isort,
                null_ls.builtins.formatting.google_java_format,
                -- # diagnostics #
                -- null_ls.builtins.diagnostics.eslint_d,
                -- null_ls.builtins.diagnostics.checkstyle,
            },
        })
        -- set up a vim motion for <Space> + c + f to automatically format our code based on which langauge server is active
        vim.keymap.set("n", "<leader>cf", vim.lsp.buf.format, { desc = "[C]ode [F]ormat" })
    end,
}
