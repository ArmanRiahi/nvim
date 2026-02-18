-- ts_ls
return {
    setup = function(capabilities)
        -- 1. Configure the server using the new name "ts_ls"
        vim.lsp.config("ts_ls", {
            default_config = {
                capabilities = capabilities,
                -- Optional: Add specific commands or init_options here
                init_options = {
                    preferences = {
                        disableSuggestions = false,
                    },
                },
            },
        })

        -- 2. Enable the server
        vim.lsp.enable("ts_ls")
    end,
}
