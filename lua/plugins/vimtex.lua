return {
  "lervag/vimtex",
  lazy = false,
  config = function()
      -- for xepersian
    vim.g.vimtex_compiler_latexmk = {
        build_dir = '',
        callback = 1,
        continuous = 1,
        executable = 'latexmk',
        hooks = {},
        options = {
            "-xelatex",
            "-file-line-error",
            "-synctex=1",
            "-interaction=nonstopmode",
            "-verbose",
        },
    }
    -- PDF viewer (use zathura or skim)
    vim.g.vimtex_view_method = 'zathura'
    vim.g.vimtex_view_zathura_options = '-x "nvr --remote +%{line} %{input}"'

    vim.keymap.set('n', '<leader>lc', ':VimtexCompile<CR>', { desc = "Vimtex Compile" })
    vim.keymap.set('n', '<leader>lv', ':VimtexView<CR>', { desc = "Vimtex View" })
    vim.keymap.set('n', '<leader>ll', ':VimtexLog<CR>', { desc = "Vimtex Log" })
  end
}
