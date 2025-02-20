return {
  "sontungexpt/sttusline",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  event = "BufEnter",
  config = function(_, opts)
    local colors = require("utils.colors")
    local diagnostics = require("sttusline.components.diagnostics")
    local filename = require("sttusline.components.filename")
    local mode = require("sttusline.components.mode")

    diagnostics.set_config({
      icons = {
        ERROR = "󰅚 ",
        WARN = "󰀪 ",
        HINT = "󰌶 ",
        INFO = " ",
      },
      order = { "ERROR", "WARN", "INFO", "HINT" },
    })
    filename.set_config({
      color = { fg = colors.grey },
    })
    mode.set_config({
      mode_colors = {
        ["STTUSLINE_NORMAL_MODE"] = { fg = colors.vi_mode_colors.normal },
        ["STTUSLINE_INSERT_MODE"] = { fg = colors.vi_mode_colors.insert },
        ["STTUSLINE_VISUAL_MODE"] = { fg = colors.vi_mode_colors.visual },
        ["STTUSLINE_COMMAND_MODE"] = { fg = colors.vi_mode_colors.command },
      },
    })

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
        filename,
        "git-branch",
        "git-diff",
        "%=",
        diagnostics,
        "lsps-formatters",
        -- "copilot",
        "indent",
        "encoding",
        "pos-cursor",
        "pos-cursor-progress",
      },
    })
  end,
}
