return {
  {
    "fredrikaverpil/godoc.nvim",
    version = "*",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    cmd = { "GoDoc" },
    ft = "godoc",
    opts = {
      adapters = {
        {
          name = "go",
          opts = {
            get_syntax_info = function()
              return {
                filetype = "godoc",
                language = "godoc", -- Enable tree-sitter godoc parser
              }
            end,
          },
        },
      },
      picker = { type = "snacks" },
      window = { type = "vsplit" },
    },
  },
  -- {
  --   -- Training mode that prevents bad vim habits and enforces good practices
  --   "m4xshen/hardtime.nvim",
  --   event = "BufEnter",
  --   dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
  --   opts = {
  --     disabled_filetypes = {
  --       "aerial",
  --       "alpha",
  --       "checkhealth",
  --       "copilot-chat",
  --       "codecompanion",
  --       "codediff-explorer",
  --       "dapui*",
  --       "dbui",
  --       "Diffview*",
  --       "Dressing*",
  --       "grug-far",
  --       "help",
  --       "httpResult",
  --       "lazy",
  --       "mason",
  --       "minifiles",
  --       "Neogit*",
  --       "neo-tree",
  --       "neo-tree*",
  --       "neotest-summary",
  --       "netrw",
  --       "noice",
  --       "notify",
  --       "NvimTree",
  --       "oil",
  --       "prompt",
  --       "qf",
  --       "snacks*",
  --       "TelescopePrompt",
  --       "Trouble",
  --       "undotree",
  --     },
  --     max_count = 6,
  --     timeout = 500,
  --   },
  -- },
  {
    "urtzienriquez/learnlua.nvim",
    cmd = "Learn",
  },
}
