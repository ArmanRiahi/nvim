local servers = {
	"lua_ls",
	"pyright",
	"clangd",
	"cssls",
	"bashls",
	"jsonls",
	"html",
	"ts_ls", -- Note: check if your version uses ts_ls or tsserver
}

return {
	-- Mason plugin setup
	{
		"williamboman/mason.nvim",
		cmd = "Mason",
		keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
		opts = {
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		},
	},

	-- Mason-LSPConfig setup
	{
		"williamboman/mason-lspconfig.nvim",
		opts = {
			ensure_installed = servers,
			automatic_installation = true,
		},
	},

	-- Core LSP config
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
		},
        opts = {
            inlay_hints = {enable = false},
        },
		config = function()
			local lspconfig = require("lspconfig")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local icons = require("config.icons")

			-- 1. Setup Diagnostics
			vim.diagnostic.config({
				signs = {
					text = {
						[vim.diagnostic.severity.ERROR] = icons.diagnostics.Error,
						[vim.diagnostic.severity.WARN] = icons.diagnostics.Warning,
						[vim.diagnostic.severity.HINT] = icons.diagnostics.Hint,
						[vim.diagnostic.severity.INFO] = icons.diagnostics.Information,
					},
				},
				virtual_text = false,
				update_in_insert = false,
				underline = true,
				severity_sort = true,
				float = {
					focusable = true,
					style = "minimal",
					border = "rounded",
					source = "always",
				},
			})

			-- 2. Setup Keymaps on LspAttach
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", {}),
				callback = function(ev)
					local opts = { buffer = ev.buf }
					vim.keymap.set("n", "<leader>ch", vim.lsp.buf.hover, { desc = "Hover", buffer = ev.buf })
					vim.keymap.set("n", "<leader>cd", vim.lsp.buf.definition, { desc = "Definition", buffer = ev.buf })
					vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Action", buffer = ev.buf })
					vim.keymap.set("n", "<leader>cR", vim.lsp.buf.rename, { desc = "Rename", buffer = ev.buf })
					vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, { desc = "Type_definition", buffer = ev.buf })

					-- ... add your telescope mappings here similarly
				end,
            })

			-- 3. Initialize Servers
            -- Inside your nvim-lspconfig config block
            for _, name in ipairs(servers) do
                local success, server = pcall(require, "plugins.lsp." .. name)

                if success and type(server) == "table" and server.setup then
                    -- Use your custom file if it exists
                    server.setup(capabilities)
                else
                    -- Fallback: Configure and enable the server with default capabilities
                    vim.lsp.config(name, {
                        default_config = {
                            capabilities = capabilities,
                        },
                    })
                    vim.lsp.enable(name)
                end
            end
        end,
	},
}

