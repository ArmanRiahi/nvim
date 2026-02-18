return {
    "windwp/nvim-autopairs",
    event = "InsertEnter", -- Load only when you start typing
    opts = {
        map_char = {
            all = "(",
            tex = "{",
        },
        enable_check_bracket_line = false,
        check_ts = true, -- Use Treesitter to check for pairs
        ts_config = {
            lua = { "string", "source" },
            javascript = { "string", "template_string" },
            java = false,
        },
        disable_filetype = { "TelescopePrompt", "spectre_panel" },
        ignored_next_char = string.gsub([[ [%w%%%'%[%"%.] ]], "%s+", ""),
        enable_moveright = true,
        disable_in_macro = false,
        enable_afterquote = true,
        map_bs = true,
        map_c_w = false,
        disable_in_visualblock = false,
        fast_wrap = {
            map = "<M-e>",
            chars = { "{", "[", "(", '"', "'" },
            pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
            offset = 0,
            end_key = "$",
            keys = "qwertyuiopzxcvbnmasdfghjkl",
            check_comma = true,
            highlight = "Search",
            highlight_grey = "Comment",
        },
    },
    config = function(_, opts)
        local autopairs = require("nvim-autopairs")
        autopairs.setup(opts)

        -- INTEGRATION: Automatically add brackets after selecting a function in completion
        local cmp_autopairs = require("nvim-autopairs.completion.cmp")
        local cmp_status, cmp = pcall(require, "cmp")
        if cmp_status then
            cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
        end
    end,
}
