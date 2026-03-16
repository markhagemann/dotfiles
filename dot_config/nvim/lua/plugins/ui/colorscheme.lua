local theme_colors = require("utils.colors").theme

return {
  {
    -- Tokyo Night color scheme with moon style variant
    "folke/tokyonight.nvim",
    branch = "main",
    dependencies = {
      -- Mode-colored CursorLineNr (replaces modicator.nvim which breaks snacks picker on nvim 0.12)
      -- Defined as a dependency so it loads after the colorscheme
      {
        dir = "",
        name = "mode-cursorlinenr",
        virtual = true,
        lazy = false,
        config = function()
          local colors = require("utils.colors").vi_mode_colors
          local mode_map = {
            ["n"] = colors.normal,
            ["i"] = colors.insert,
            ["v"] = colors.visual,
            ["V"] = colors.visual,
            ["\22"] = colors.visual,
            ["c"] = colors.command,
            ["R"] = colors.command,
            ["t"] = colors.terminal,
          }

          local function update_cursorlinenr()
            if vim.bo.buftype == "nofile" then
              return
            end
            local mode = vim.api.nvim_get_mode().mode:sub(1, 1)
            local fg = mode_map[mode] or colors.normal
            vim.api.nvim_set_hl(0, "CursorLineNr", { fg = fg, bold = false })
          end

          vim.api.nvim_create_autocmd("ModeChanged", {
            callback = update_cursorlinenr,
          })

          update_cursorlinenr()
        end,
      },
      {
        -- Make Neovim background transparent
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
      on_highlights = function(hl, colors)
        hl.Visual = { bg = theme_colors.bpurple }
        hl.FloatBorder = { fg = theme_colors.bpurple }
        hl.WinSeparator = { fg = theme_colors.bpurple }
        hl.SnacksDashboardKey = { fg = theme_colors.bmagenta }
        hl.SnacksIndent = { fg = theme_colors.bpurple }
        hl.SnacksPickerAuEvent = { fg = theme_colors.bmagenta }
        hl.SnacksPickerInputBorder = { fg = theme_colors.bpurple }
        hl.SnacksPickerInputTitle = { fg = theme_colors.red }
        hl.SnacksPickerListTitle = { fg = theme_colors.magenta }
        hl.SnacksPickerPrompt = { fg = theme_colors.black }
        hl.SnacksPickerPreviewTitle = { fg = theme_colors.magenta }
        hl.SnacksPickerTitle = { fg = theme_colors.magenta }
        hl.NoiceCmdlineIcon = { fg = theme_colors.magenta }
        hl.NoiceCmdlinePopupBorder = { fg = theme_colors.bmagenta }
        hl.NoiceCmdlinePopupTitle = { fg = theme_colors.magenta }
        hl.NoiceCmdlinePopupTitleCalculator = { fg = theme_colors.magenta }
        hl.NoiceCmdlinePopupTitleCmdline = { fg = theme_colors.magenta }
        hl.NoiceCmdlinePopupTitleHelp = { fg = theme_colors.magenta }
        hl.NoiceCmdlinePopupTitleFilter = { fg = theme_colors.magenta }
        hl.NoiceCmdlinePopupTitleSearch = { fg = theme_colors.magenta }
        hl.NoicePopupBorder = { fg = theme_colors.bpurple }
        hl.NoicePopupTitle = { fg = theme_colors.magenta }
      end,
    },
    config = function(_, opts)
      require("tokyonight").setup(opts)
      vim.cmd([[colorscheme tokyonight]])
    end,
  },
}
