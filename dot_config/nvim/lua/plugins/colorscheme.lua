return {
  {
    "folke/tokyonight.nvim",
    branch = "main",
    dependencies = {
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
                bold = false,
              },
            },
          })
        end,
      },
      {
        "xiyaowong/transparent.nvim",
        lazy = false,
        opts = {},
        config = function(_, opts)
          require("transparent").setup(opts)

          vim.cmd("TransparentEnable")

          -- There are issues with this - some background highlight can never be reverted even though other stuff is transparent
          -- local toggle_transparency = function()
          --   vim.cmd("TransparentToggle")
          --   vim.cmd(":lua print('Transparency enabled:', vim.g.transparent_enabled)")
          --   require("lazy.core.loader").reload(require("lazy.core.config").plugins["tokyonight.nvim"])
          -- end
          -- vim.keymap.set("n", "<leader>tt", toggle_transparency, { desc = "Transparency toggle" })
        end,
      },
    },
    -- cache = false,
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
        sidebars = "transparent",
        floats = "transparent",
      },
      transparent = true,
    },
    config = function(_, opts)
      require("tokyonight").setup(opts)
      vim.cmd([[colorscheme tokyonight]])
    end,
  },
}
