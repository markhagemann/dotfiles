return {
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      auto_install = true,
    },
  },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      local lspconfig = require("lspconfig")
      lspconfig.tsserver.setup({
        capabilites = capabilities,
      })
      lspconfig.html.setup({
        capabilites = capabilities,
      })

      lspconfig.lua_ls.setup({
        capabilites = capabilities,
        settings = {
          Lua = {
            completion = {
              callSnippet = "Replace",
            },
            diagnostics = {
              globals = { "vim" },
            },
          },
        },
      })

      vim.keymap.set("n", "F2", "<cmd>Lspsaga rename<CR>")
      vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>")
      vim.keymap.set("n", "gi", "<cmd>Lspsaga finder imp<CR>")
      vim.keymap.set("n", "gc", "<cmd>Lspsaga go_to_definition<CR>")
      vim.keymap.set("n", "gd", "<cmd>Lspsaga peek_definition<CR>")
      vim.keymap.set("n", "td", "<cmd>Lspsaga peek_type_definition<CR>")
      vim.keymap.set("n", "gr", "<cmd>Lspsaga finder<CR>")
      vim.keymap.set("n", "]e", "<cmd>Lspsaga diagnostic_jump_prev<CR>")
      vim.keymap.set("n", "[e", "<cmd>Lspsaga diagnostic_jump_next<CR>")
      vim.keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>")
    end,
  },

  -- Extras
  {
    "aznhe21/actions-preview.nvim",
    event = "LspAttach",
    config = function()
      vim.keymap.set({ "v", "n" }, "gf", require("actions-preview").code_actions)
    end,
  },
  -- {
  --   "dmmulroy/tsc.nvim",
  --   event = "VeryLazy",
  -- },
  {
    'nvimdev/lspsaga.nvim',
    event = "LspAttach",
    config = function()
      require('lspsaga').setup({})
    end,
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-tree/nvim-web-devicons',
    }
  },
  {
    event = { "BufReadPre", "BufNewFile" },
    "hinell/lsp-timeout.nvim",
    dependencies = { "neovim/nvim-lspconfig" },
  },
  {
    "Fildo7525/pretty_hover",
    event = "LspAttach",
    opts = {},
  },
  -- {
  --   "pmizio/typescript-tools.nvim",
  --   event = "LspAttach",
  --   dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
  --   opts = {},
  -- },
  -- {
  --   "ray-x/lsp_signature.nvim",
  --   event = "VeryLazy",
  --   opts = {},
  --   config = function(_, opts)
  --     require("lsp_signature").setup(opts)
  --   end,
  -- },
  {
    "simrat39/symbols-outline.nvim",
    keys = { { "<leader>cs", "<cmd>SymbolsOutline<cr>", desc = "Symbols Outline" } },
    config = function()
      require("symbols-outline").setup()
    end,
  },
  -- {
  --   "VidocqH/lsp-lens.nvim",
  --   event = "VeryLazy",
  --   config = function()
  --     require("lsp-lens").setup({
  --       sections = {
  --         definition = true,
  --         references = true,
  --         implements = true,
  --         git_authors = false,
  --       },
  --     })
  --   end,
  -- },
}
