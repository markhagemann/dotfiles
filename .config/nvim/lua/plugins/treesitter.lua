return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {
      auto_install = true,
      ensure_installed = {
        "markdown",
        "markdown_inline",
        "lua",
        "vim",
        "html",
        "css",
        "go",
        "yaml",
        "toml",
        "json",
        "sql",
        "graphql",
        "javascript",
        "typescript",
      },
      highlight = { enable = true },
      indent = { enable = true },
    },
    config = function(_, opts)
      local config = require("nvim-treesitter.configs")
      config.setup(opts)
    end,
  },
}
