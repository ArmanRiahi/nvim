local servers = {
	"lua_ls",
	"pyright",
	"clangd",
	"cssls",
	"bashls",
	"jsonls",
	"html",
	"ts_ls", -- Note: check if your version uses ts_ls or tsserver
    "jdtls",
    "texlab",
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

-- mason nvim dap utilizes mason to automatically ensure debug adapters you want installed are installed, mason-lspconfig will not automatically install debug adapters for us
    {
        "jay-babu/mason-nvim-dap.nvim",
        config = function()
            -- ensure the java debug adapter is installed
            require("mason-nvim-dap").setup({
                ensure_installed = { "java-debug-adapter", "java-test" }
            })
        end
    },

	-- Core LSP config
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
		},
        opts = {
            inlay_hints = {enable = true},
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
                    -- Set vim motion for <Space> + c + h to show code documentation about the code the cursor is currently over if available
                    vim.keymap.set("n", "<leader>ch", vim.lsp.buf.hover, { desc = "[C]ode [H]over Documentation", buffer = ev.buf })
                    -- Set vim motion for <Space> + c + d to go where the code/variable under the cursor was defined
                    vim.keymap.set("n", "<leader>cd", vim.lsp.buf.definition, { desc = "[C]ode Goto [D]efinition", buffer = ev.buf })
                    -- Set vim motion for <Space> + c + a for display code action suggestions for code diagnostics in both normal and visual mode
                    vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "[C]ode [A]ctions", buffer = ev.buf })
                    -- Set vim motion for <Space> + c + r to display references to the code under the cursor
                    vim.keymap.set("n", "<leader>cr", require("telescope.builtin").lsp_references, { desc = "[C]ode Goto [R]eferences", buffer = ev.buf })
                    -- Set vim motion for <Space> + c + i to display implementations to the code under the cursor
                    vim.keymap.set("n", "<leader>ci", require("telescope.builtin").lsp_implementations, { desc = "[C]ode Goto [I]mplementations", buffer = ev.buf })
                    -- Set a vim motion for <Space> + c + <Shift>R to smartly rename the code under the cursor
                    vim.keymap.set("n", "<leader>cR", vim.lsp.buf.rename, { desc = "[C]ode [R]ename", buffer = ev.buf })
                    -- Set a vim motion for <Space> + c + <Shift>D to go to where the code/object was declared in the project (class file)
                    vim.keymap.set("n", "<leader>cD", vim.lsp.buf.declaration, { desc = "[C]ode Goto [D]eclaration", buffer = ev.buf })

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

