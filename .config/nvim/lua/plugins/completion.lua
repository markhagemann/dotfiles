return {
  {
    "L3MON4D3/LuaSnip",
    event = "InsertEnter",
    dependencies = {
      "rafamadriz/friendly-snippets",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "L3MON4D3/LuaSnip", -- Snippets
      "onsails/lspkind-nvim", -- Completion menu icons
      "saadparwaiz1/cmp_luasnip", -- Snippets
      "hrsh7th/cmp-nvim-lsp", -- LSP completion
      "hrsh7th/cmp-buffer", -- Buffer completion
      "hrsh7th/cmp-path", -- Path completion
      "hrsh7th/cmp-cmdline", -- Command-line completion
      "hrsh7th/cmp-nvim-lua", -- Nvim builtins completion
      "hrsh7th/cmp-nvim-lsp-signature-help", -- Signature
    },
  },
}
