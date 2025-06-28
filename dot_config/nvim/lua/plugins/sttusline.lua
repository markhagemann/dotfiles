return {
  "sontungexpt/sttusline",
  dependencies = {
    "echasnovski/mini.icons",
  },
  event = "BufEnter",
  config = function(_, opts)
    local colors = require("utils.colors")
    local diagnostics = require("sttusline.components.diagnostics")
    -- local filename = require("sttusline.components.filename")
    local mode = require("sttusline.components.mode")
    local git_branch = require("sttusline.components.git-branch")
    local git_diff = require("sttusline.components.git-diff")
    local lsps_formatters = require("sttusline.components.lsps-formatters")
    local indent = require("sttusline.components.indent")
    local encoding = require("sttusline.components.encoding")
    local pos_cursor = require("sttusline.components.pos-cursor")
    local pos_cursor_progress = require("sttusline.components.pos-cursor-progress")

    local none = "Normal"

    diagnostics.set_config({
      icons = {
        ERROR = "󰅚 ",
        WARN = "󰀪 ",
        HINT = "󰌶 ",
        INFO = " ",
      },
      order = { "ERROR", "WARN", "INFO", "HINT" },
    })
    -- filename.set_colors({
    --   { bg = none },
    --   {
    --     fg = colors.theme.black,
    --     bg = none,
    --   },
    -- })
    mode.set_config({
      mode_colors = {
        ["STTUSLINE_NORMAL_MODE"] = { fg = colors.vi_mode_colors.normal, bg = none },
        ["STTUSLINE_INSERT_MODE"] = { fg = colors.vi_mode_colors.insert, bg = none },
        ["STTUSLINE_VISUAL_MODE"] = { fg = colors.vi_mode_colors.visual, bg = none },
        ["STTUSLINE_COMMAND_MODE"] = { fg = colors.vi_mode_colors.command, bg = none },
      },
    })
    git_branch.set_colors({ fg = colors.theme.bmagenta, bg = none })
    git_diff.set_colors({ fg = colors.theme.bmagenta, bg = none })
    git_diff.set_colors({ fg = colors.theme.bmagenta, bg = none })
    lsps_formatters.set_colors({ fg = colors.theme.bblue, bg = none })
    indent.set_colors({ fg = colors.theme.bgreen, bg = none })
    encoding.set_colors({ fg = colors.theme.red, bg = none })
    pos_cursor.set_colors({ fg = colors.theme.byellow, bg = none })
    pos_cursor_progress.set_colors({ fg = colors.theme.yellow, bg = none })

    require("sttusline").setup({
      statusline_color = "StatusLine",

      laststatus = 3,
      disabled = {
        filetypes = {
          "NeoTree",
          "NvimTree",
          "lazy",
        },
        buftypes = {
          "terminal",
        },
      },
      components = {
        mode,
        -- filename,
        git_branch,
        git_diff,
        diagnostics,
        "%=",
        lsps_formatters,
        -- "copilot",
        indent,
        encoding,
        pos_cursor,
        pos_cursor_progress,
      },
    })
  end,
}
