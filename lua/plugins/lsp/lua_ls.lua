return {
    setup = function(capabilities)
        -- 1. Configure the server in the core Neovim LSP config table
        vim.lsp.config("lua_ls", {
            default_config = {
                capabilities = capabilities,
                settings = {
                    Lua = {
                        diagnostics = { globals = { "vim" } },
                        workspace = {
                            checkThirdParty = false,
                            library = vim.api.nvim_get_runtime_file("", true),
                        },
                    },
                },
            },
        })

        -- 2. Enable the server
        vim.lsp.enable("lua_ls")
    end,
}
