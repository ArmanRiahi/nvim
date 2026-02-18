return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
    },
    lazy = false,
    config = function()
        vim.keymap.set("n", "<C-n>", "<cmd>Neotree toggle left<CR>", { desc = "Toggle Neo-tree sidebar" })

        local icons = require("config.icons")

        require("neo-tree").setup({
            close_if_last_window = false,
            popup_border_style = "rounded",
            enable_git_status = true,
            enable_diagnostics = true,
            source_selector = {
                sources = { -- table
                    {
                        source = "filesystem", -- string
                        display_name = " 󰉓 Files ", -- string | nil
                    },
                    {
                        source = "buffers", -- string
                        display_name = " 󰈚 Buffers ", -- string | nil
                    },
                    {
                        source = "git_status", -- string
                        display_name = " 󰊢 Git ", -- string | nil
                    },
                },
            },
            filesystem = {
                filtered_items = {
                    visible = false, -- show hidden files
                    hide_dotfiles = true, -- do NOT hide .files
                    hide_gitignored = true, -- optional: show .gitignored files too
                },
            },
            window = {
                position = "left", -- open as a left sidebar
                width = 30, -- default width of the Neo-tree panel
            },

            renderer = {
                add_trailing = false,
                group_empty = false,
                highlight_git = false,
                full_name = false,
                highlight_opened_files = "none",
                root_folder_label = ":t",
                indent_width = 2,
                indent_markers = {
                    enable = false,
                    inline_arrows = true,
                    icons = {
                        corner = "└",
                        edge = "│",
                        item = "│",
                        none = " ",
                    },
                },
                icons = {
                    git_placement = "before",
                    padding = " ",
                    symlink_arrow = " ➛ ",
                    glyphs = {
                        default = icons.ui.Text,
                        symlink = icons.ui.FileSymlink,
                        bookmark = icons.ui.BookMark,
                        folder = {
                            arrow_closed = icons.ui.ChevronRight,
                            arrow_open = icons.ui.ChevronShortDown,
                            default = icons.ui.Folder,
                            open = icons.ui.FolderOpen,
                            empty = icons.ui.EmptyFolder,
                            empty_open = icons.ui.EmptyFolderOpen,
                            symlink = icons.ui.FolderSymlink,
                            symlink_open = icons.ui.FolderOpen,
                        },
                        git = {
                            unstaged = icons.git.FileUnstaged,
                            staged = icons.git.FileStaged,
                            unmerged = icons.git.FileUnmerged,
                            renamed = icons.git.FileRenamed,
                            untracked = icons.git.FileUntracked,
                            deleted = icons.git.FileDeleted,
                            ignored = icons.git.FileIgnored,
                        },
                    },
                },
                special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md" },
                symlink_destination = true,
            },
            update_focused_file = {
                enable = true,
                debounce_delay = 15,
                update_root = true,
                ignore_list = {},
            },

            diagnostics = {
                enable = true,
                show_on_dirs = false,
                show_on_open_dirs = true,
                debounce_delay = 50,
                severity = {
                    min = vim.diagnostic.severity.HINT,
                    max = vim.diagnostic.severity.ERROR,
                },
                icons = {
                    hint = icons.diagnostics.BoldHint,
                    info = icons.diagnostics.BoldInformation,
                    warning = icons.diagnostics.BoldWarning,
                    error = icons.diagnostics.BoldError,
                },
            },
        })
    end,
}
