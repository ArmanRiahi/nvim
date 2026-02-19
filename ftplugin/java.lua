local home = os.getenv("HOME")
local jdtls = require("jdtls")

-- This determines where the eclipse.jdt.ls data is stored for the current project
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = home .. "/.cache/jdtls/workspace/" .. project_name

local config = {
  cmd = {
      "java",
      "-Declipse.application=org.eclipse.jdt.ls.core.id1",
      "-Dosgi.bundles.defaultStartLevel=4",
      "-Declipse.product=org.eclipse.jdt.ls.core.product",
      "-Dlog.level=ALL",
      "-Xmx1G",
      "--add-modules=ALL-SYSTEM",
      "--add-opens", "java.base/java.util=ALL-UNNAMED",
      "--add-opens", "java.base/java.lang=ALL-UNNAMED",

      -- Point to the Mason-installed jar
      "-jar", vim.fn.expand("~/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar"),

      -- Point to the Mason-installed config (change 'linux' to 'mac' if on macOS)
      "-configuration", vim.fn.expand("~/.local/share/nvim/mason/packages/jdtls/config_linux"),

      "-data", workspace_dir,
  },
  root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }),

  settings = {
    java = {
      signatureHelp = { enabled = true },
      completion = {
        favoriteStaticMembers = {
          "org.hamcrest.MatcherAssert.assertThat",
          "org.hamcrest.Matchers.*",
          "org.junit.jupiter.api.Assertions.*",
          "java.util.Objects.requireNonNull",
        },
      },
    },
  },
  on_attach = function(client, bufnr)
    -- Java-specific keymaps
    local opts = { silent = true, buffer = bufnr }
    vim.keymap.set('n', '<leader>oi', jdtls.organize_imports, opts)
    vim.keymap.set('n', '<leader>ev', jdtls.extract_variable, opts)
    vim.keymap.set('n', '<leader>ec', jdtls.extract_constant, opts)
  end,
}

jdtls.start_or_attach(config)
