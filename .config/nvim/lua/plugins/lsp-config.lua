return {
  {
    "folke/neodev.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {},
    config = function()
      require("neodev").setup({})
    end,
  },
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
              callSnippet = "Replace"
            }
          }
        }
      })

      vim.keymap.set("n", "F2", "<cmd>LspUI rename<CR>")
      vim.keymap.set("n", "K", "<cmd>LspUI hover<CR>")
      vim.keymap.set("n", "gi", "<cmd>LspUI implementation<CR>")
      vim.keymap.set("n", "gc", "<cmd>LspUI declaration<CR>")
      vim.keymap.set("n", "gd", "<cmd>LspUI definition<CR>")
      vim.keymap.set("n", "td", "<cmd>LspUI type_definition<CR>")
      vim.keymap.set("n", "gr", "<cmd>LspUI reference<CR>")
      vim.keymap.set("n", "]e", "<cmd>LspUI diagnostic prev<CR>")
      vim.keymap.set("n", "[e", "<cmd>LspUI diagnostic next<CR>")
      vim.keymap.set("n", "<leader>ca", "<cmd>LspUI code_action<CR>")
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
  {
    "dmmulroy/tsc.nvim",
    event = "VeryLazy",
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
  {
    "pmizio/typescript-tools.nvim",
    event = "LspAttach",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = {},
  },
  {
    "ray-x/lsp_signature.nvim",
    event = "VeryLazy",
    opts = {},
    config = function(_, opts) require 'lsp_signature'.setup(opts) end
  },
  {
    "jinzhongjia/LspUI.nvim",
    event = "VeryLazy",
    branch = "main",
    config = function()
      require("LspUI").setup({
        prompt = false,
      })
    end
  },
  {
    "simrat39/symbols-outline.nvim",
    keys = { { "<leader>cs", "<cmd>SymbolsOutline<cr>", desc = "Symbols Outline" } },
    config = function()
      require("symbols-outline").setup()
    end,
  },
  {
    'VidocqH/lsp-lens.nvim',
    event = "VeryLazy",
    config = function()
      require 'lsp-lens'.setup({})
    end
  }
}
