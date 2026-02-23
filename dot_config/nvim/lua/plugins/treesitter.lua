return {
  {
    -- Syntax highlighting and code parsing using tree-sitter
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    build = ":TSUpdate",
    opts = {
      auto_install = true,
      ensure_installed = {
        "bash",
        "css",
        "git_config",
        "gitignore",
        "go",
        "graphql",
        "html",
        "javascript",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "regex",
        "scss",
        "sql",
        "tmux",
        "toml",
        "typescript",
        "vim",
        "vue",
        "yaml",
      },
      highlight = { enable = true },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = false,
          node_decremental = "<bs>",
        },
      },
      indent = { enable = true },
    },
    config = function(_, opts)
      local config = require("nvim-treesitter.config")
      -- New nvim-treesitter (main) only uses install_dir; ensure_installed/auto_install are ignored.
      config.setup(opts.install_dir and { install_dir = opts.install_dir } or {})

      -- Install parsers from our list when missing (replaces old ensure_installed + auto_install).
      local wanted = opts.ensure_installed
      if wanted and #wanted > 0 then
        vim.defer_fn(function()
          local installed = config.get_installed("parsers")
          local to_install = vim.tbl_filter(function(lang)
            return not vim.tbl_contains(installed, lang)
          end, wanted)
          if #to_install > 0 then
            require("nvim-treesitter.install").install(to_install, { summary = true })
          end
        end, 100)
      end
    end,
  },
}
