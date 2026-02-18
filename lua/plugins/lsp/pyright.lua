-- pyright
return {
    setup = function(capabilities)
        -- 1. Configure Pyright in the core LSP table
        vim.lsp.config("pyright", {
            default_config = {
                capabilities = capabilities,
                settings = {
                    python = {
                        analysis = {
                            autoSearchPaths = true,
                            useLibraryCodeForTypes = true,
                            typeCheckingMode = "basic", -- options: "off", "basic", "strict"
                        },
                    },
                },
            },
        })

        -- 2. Enable the server
        vim.lsp.enable("pyright")
    end,
}
