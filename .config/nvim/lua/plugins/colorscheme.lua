return {
  {
    "catppuccin/nvim",
    lazy = false,
    name = "catppuccin",
    priority = 1000,
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
        flavour = "mocha",             -- latte, frappe, macchiato, mocha
        transparent_background = true, -- disables setting the background color.
        -- dim_inactive = {
        --   enabled = false, -- dims the background color of inactive window
        --   shade = "dark",
        --   percentage = 0.15, -- percentage of the shade to apply to the inactive window
        -- },
        -- no_italic = false, -- Force no italic
        -- no_bold = false, -- Force no bold
        -- no_underline = false, -- Force no underline
        styles = {                 -- Handles the styles of general hi groups (see `:h highlight-args`):
          comments = { "italic" }, -- Change the style of comments
          conditionals = { "italic" },
          -- loops = {},
          -- functions = {},
          -- keywords = {},
          -- strings = {},
          -- variables = {},
          -- numbers = {},
          -- booleans = {},
          -- properties = {},
          -- types = {},
          -- operators = {},
        },
        integrations = {
          telescope = true,
          -- cmp = true,
          -- gitsigns = true,
          -- nvimtree = true,
          -- notify = false,
          -- treesitter = true,
          -- mini = {
          --   enabled = true,
          --   indentscope_color = "",
          -- },
          -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
        },
      })
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
