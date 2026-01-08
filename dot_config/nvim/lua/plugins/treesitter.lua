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
      local config = require("nvim-treesitter.configs")
      config.setup(opts)
    end,
  },
}
