return {
  {
    "catppuccin/nvim",
    lazy = false,
    name = "catppuccin",
    priority = 1000,
    opts = {
      styles = {
        keywords = { "italic" },
        variables = { "italic" },
        booleans = { "italic" },
        properties = { "italic" },
      },
      -- Integrations
      integrations = {
        gitsigns = true,
        nvimtree = true,
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

        return {
          -- Cmp Menu
          PmenuSel = { fg = colors.base, bg = colors.maroon, style = { "bold" } },

          -- Telescope
          -- TelescopeBorder = { fg = colors.blue },
          -- TelescopeSelectionCaret = { fg = colors.flamingo },
          -- TelescopeSelection = { fg = colors.text, bg = colors.surface0, style = { "bold" } },
          -- TelescopeMatching = { fg = colors.blue },
          -- TelescopePromptPrefix = { fg = colors.yellow, bg = colors.crust },
          -- TelescopePromptNormal = { bg = colors.crust },
          -- TelescopeResultsNormal = { bg = colors.mantle },
          -- TelescopePreviewNormal = { bg = colors.crust },
          -- TelescopePromptBorder = { bg = colors.crust, fg = colors.crust },
          -- TelescopeResultsBorder = { bg = colors.mantle, fg = colors.mantle },
          -- TelescopePreviewBorder = { bg = colors.crust, fg = colors.crust },
          -- TelescopePromptTitle = { fg = colors.crust, bg = colors.mauve },
          -- TelescopeResultsTitle = { fg = colors.crust, bg = colors.mauve },
          -- TelescopePreviewTitle = { fg = colors.crust, bg = colors.mauve },
          TelescopeMatching = { fg = colors.flamingo },
          TelescopeSelection = { fg = colors.text, bg = colors.surface0, bold = true },

          TelescopePromptPrefix = { bg = colors.surface0 },
          TelescopePromptNormal = { bg = colors.surface0 },
          TelescopeResultsNormal = { bg = colors.mantle },
          TelescopePreviewNormal = { bg = colors.mantle },
          TelescopePromptBorder = { bg = colors.surface0, fg = colors.surface0 },
          TelescopeResultsBorder = { bg = colors.mantle, fg = colors.mantle },
          TelescopePreviewBorder = { bg = colors.mantle, fg = colors.mantle },
          TelescopePromptTitle = { bg = colors.pink, fg = colors.mantle },
          TelescopeResultsTitle = { fg = colors.mantle },
          TelescopePreviewTitle = { bg = colors.green, fg = colors.mantle },

          -- Bufferline
          BufferLineIndicatorSelected = { fg = colors.pink },
          BufferLineIndicator = { fg = colors.base },
          BufferLineModifiedSelected = { fg = colors.teal },
          TabLineSel = { bg = colors.pink },

          -- Cursorline & Linenumbers
          -- CursorLine = { bg = colors.mantle },
        }
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
    lazy = true,
    keys = {
      -- Transparency Toggle
      { "TT", ":TransparentToggle<CR>", desc = "Toggle Transparency" },
    },
  },
}
