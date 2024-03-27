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
        fidget = true,
        gitsigns = true,
        harpoon = true,
        hop = true,
        illuminate = true,
        markdown = true,
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
        noice = true,
        notify = true,
        nvimtree = {
          enabled = true,
          show_root = true,
          transparent_panel = true,
        },
        telescope = true,
        treesitter = true,
        treesitter_context = true,
        which_key = true,
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
