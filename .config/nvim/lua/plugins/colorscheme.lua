return {
  {
    "catppuccin/nvim",
    lazy = false,
    name = "catppuccin",
    priority = 1000,
    opts = {
      transparent_background = true,
      styles = {
        keywords = { "italic" },
        properties = { "italic" },
      },
      -- Integrations
      integrations = {
        gitsigns = true,
        fidget = true,
        notify = true,
        nvimtree = {
          enabled = true,
          show_root = true,
          transparent_panel = true,
        },
        telescope = true,
        illuminate = true,
        treesitter = true,
        treesitter_context = true,
        native_lsp = {
          enabled = true,
          virtual_text = {
            errors = { "italic" },
            hints = { "italic" },
            warnings = { "italic" },
            information = { "italic" },
          },
          underlines = {
            errors = { "undercurl" },
            hints = { "undercurl" },
            warnings = { "undercurl" },
            information = { "undercurl" },
          },
        },
        hop = true,
        markdown = true,
      },
      custom_highlights = function(colors)
        local TelescopeColor = {}

        for hl, col in pairs(TelescopeColor) do
          vim.api.nvim_set_hl(0, hl, col)
        end

        return {}
      end,
      highlight_overrides = {},
      color_overrides = {},
    },
    config = function(_, opts)
      local colors = require("catppuccin.palettes").get_palette()

      require("catppuccin").setup(opts)

      -- setup must be called before loading
      vim.cmd("colorscheme catppuccin-mocha")
    end,
  },
  {
    "xiyaowong/nvim-transparent",
    lazy = false,
    keys = {
      -- Transparency Toggle
      { "TT", ":TransparentToggle<CR>", desc = "Toggle Transparency" },
    },
  },
}
