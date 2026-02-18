return {
	"nvim-treesitter/nvim-treesitter",
	dependencies = {
		"windwp/nvim-ts-autotag",
	},
	build = ":TSUpdate",
	config = function()
		-- Correct module call
		local configs = require("nvim-treesitter.config")

		configs.setup({
			-- Ensure all the languages you use are here
			ensure_installed = {
				"c", "cpp", "lua", "rust", "vim", "vimdoc", "query", 
				"markdown", "markdown_inline", "javascript", "python", 
				"java", "typescript", "html", "css", "json", "tsx", 
				"gitignore", "go", "latex", "bash",
			},
			
			-- Sync install for better stability
			sync_install = false,
			auto_install = true,

			highlight = { 
				enable = true, 
				-- Optional: disable slow treesitter highlight for large files
				disable = function(lang, buf)
					local max_filesize = 100 * 1024 -- 100 KB
					local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
					if ok and stats and stats.size > max_filesize then
						return true
					end
				end,
			},
			
			indent = { enable = true },
			autotag = { enable = true },

			-- EXTRA: Smart selection based on code structure
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<C-space>", -- Ctrl + Space to start selecting
					node_incremental = "<C-space>", -- Increment to the next scope
					scope_incremental = false,
					node_decremental = "<bs>", -- Backspace to shrink selection
				},
			},
		})
	end,
}
