-- Taken from https://github.com/olimorris/dotfiles
return {
  -- Highly customizable statusline and winbar plugin
  "rebelot/heirline.nvim",
  event = "BufEnter",
  config = function()
    require("heirline").setup({
      statusline = require("plugins.ui.heirline.statusline"),
    })
  end,
}
