-- clangd
return {
    setup = function(capabilities)
        -- 1. Configure clangd in the core LSP table
        vim.lsp.config("clangd", {
            default_config = {
                capabilities = capabilities,
                -- Specific fix for clangd encoding warnings
                cmd = {
                    "clangd",
                    "--background-index",
                    "--clang-tidy",
                    "--header-insertion=iwyu",
                    "--completion-style=detailed",
                    "--function-arg-placeholders",
                    "--fallback-style=llvm",
                },
                init_options = {
                    fallbackFlags = { "-std=c++20" },
                },
            },
        })

        -- 2. Enable the server
        vim.lsp.enable("clangd")
    end,
}
