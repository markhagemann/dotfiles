return {
  {
    "catppuccin/nvim",
    lazy = false,
    name = "catppuccin",
    priority = 1000,
    opts = {},
    config = function()
      vim.cmd.colorscheme("catppuccin")

      local colors = require("catppuccin.palettes").get_palette()
      local TelescopeColor = {
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
      }

      for hl, col in pairs(TelescopeColor) do
        vim.api.nvim_set_hl(0, hl, col)
      end

      require("catppuccin").setup({
        flavour = "mocha", -- latte, frappe, macchiato, mocha
        dim_inactive = {
          enabled = false, -- dims the background color of inactive window
          shade = "dark",
          percentage = 0.15, -- percentage of the shade to apply to the inactive window
        },
        integrations = {
          cmp = true,
          gitsigns = true,
          mini = {
            enabled = true,
            indentscope_color = "",
          },
          nvimtree = true,
          treesitter = true,
          telescope = true,
          notify = false,
          ufo = true,
        },
      })

      -- setup must be called before loading
      vim.cmd.colorscheme("catppuccin")
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
