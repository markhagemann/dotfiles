return {
  "sontungexpt/sttusline",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  event = { "BufEnter" },
  config = function(_, opts)
    local colors = require("utils.colors")
    local mode = require("sttusline.components.mode")

    mode.set_config({
      mode_colors = {
        ["STTUSLINE_NORMAL_MODE"] = { fg = colors.vi_mode_colors.normal },
        ["STTUSLINE_INSERT_MODE"] = { fg = colors.vi_mode_colors.insert },
        ["STTUSLINE_VISUAL_MODE"] = { fg = colors.vi_mode_colors.visual },
        ["STTUSLINE_NTERMINAL_MODE"] = { fg = colors.vi_mode_colors.terminal },
        ["STTUSLINE_TERMINAL_MODE"] = { fg = colors.vi_mode_colors.terminal },
        ["STTUSLINE_REPLACE_MODE"] = { fg = colors.vi_mode_colors.replace },
        ["STTUSLINE_SELECT_MODE"] = { fg = colors.vi_mode_colors.block },
        ["STTUSLINE_COMMAND_MODE"] = { fg = colors.vi_mode_colors.command },
        ["STTUSLINE_CONFIRM_MODE"] = { fg = colors.vi_mode_colors.confirm },
      },
    })

    require("sttusline").setup({
      statusline_color = "StatusLine",

      laststatus = 3,
      disabled = {
        filetypes = {
          "NvimTree",
          "lazy",
        },
        buftypes = {
          "terminal",
        },
      },
      components = {
        mode,
        "filename",
        "git-branch",
        "git-diff",
        "%=",
        "diagnostics",
        -- "lsps-formatters",
        "copilot",
        "indent",
        "encoding",
        "pos-cursor",
        "pos-cursor-progress",
      },
    })
  end,
}
