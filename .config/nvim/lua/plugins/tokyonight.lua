return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      style = "moon", -- The theme comes in three styles, `storm`, a darker variant `night` and `day`
      styles = {
        -- Style to be applied to different syntax groups
        -- Value is any valid attr-list value for `:help nvim_set_hl`
        -- comments = { italic = true },
        -- keywords = { italic = true },
        -- functions = {},
        -- variables = {},
        -- Background styles. Can be "dark", "transparent" or "normal"
        sidebars = "dark",
        floats = "transparent",
      },
      transparent = vim.g.transparent_enabled,
      on_highlights = function(hl, c)
        local prompt = "#2d3149"
        hl.CursorLine = {
          bg = "none",
        }
        hl.FoldColumn = {
          bg = "none",
          fg = prompt,
        }
        hl.SignColumn = {
          bg = "none",
          fg = prompt,
        }
        hl.NvimTreeWinSeparator = {
          bg = "none",
          fg = prompt,
        }
        hl.TelescopeNormal = {
          bg = c.bg_dark,
          fg = c.fg_dark,
        }
        hl.TelescopeBorder = {
          bg = c.bg_dark,
          fg = c.bg_dark,
        }
        hl.TelescopePromptNormal = {
          bg = prompt,
        }
        hl.TelescopePromptBorder = {
          bg = prompt,
          fg = prompt,
        }
        hl.TelescopePromptTitle = {
          bg = prompt,
          fg = prompt,
        }
        hl.TelescopePreviewTitle = {
          bg = c.bg_dark,
          fg = c.bg_dark,
        }
        hl.TelescopeResultsTitle = {
          bg = c.bg_dark,
          fg = c.bg_dark,
        }
        hl.WhichKeyBorder = {
          bg = "none",
          fg = prompt,
        }
      end,
    },
    config = function(_, opts)
      require("tokyonight").setup({ opts })
      vim.cmd([[colorscheme tokyonight-moon]])

      -- There are issues with this - some background highlight can never be reverted even though other stuff is transparent
      vim.keymap.set("n", "<leader>tt", function()
        vim.cmd("TransparentToggle")
        vim.cmd(":lua print('Transparency enabled:', vim.g.transparent_enabled)")
        -- vim.cmd("Lazy reload tokyonight.nvim")
        require("lazy.core.loader").reload(require("lazy.core.config").plugins["tokyonight.nvim"])
      end, { desc = "[t]ransparency [t]oggle" })
    end,
  },
  {
    "xiyaowong/transparent.nvim",
    lazy = false,
    -- keys = {
    --   {
    --     "<leader>tt",
    --     "<cmd>TransparentToggle<cr>",
    --     desc = "[t]ransparency [t]oggle",
    --   },
    -- },
  },
  {
    "mawkler/modicator.nvim",
    event = "BufEnter",
    after = "tokyonight/nvim",
    config = function()
      local colors = require("utils.colors")
      local modes = {
        "Normal",
        "Insert",
        "Visual",
        "Command",
        "Replace",
        "Select",
        "Terminal",
        "TerminalNormal",
      }

      for _, mode in pairs(modes) do
        local fg_color = colors.vi_mode_colors[mode:lower()]
        vim.api.nvim_set_hl(0, mode .. "Mode", { fg = fg_color })
      end

      require("modicator").setup({
        show_warnings = false,
        highlights = {
          defaults = {
            bold = true,
          },
        },
      })
    end,
  },
}
