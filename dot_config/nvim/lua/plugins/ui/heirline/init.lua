return {
  "rebelot/heirline.nvim",
  event = "BufEnter",
  config = function()
    require("heirline").setup({
      statusline = require("plugins.ui.heirline.statusline"),
    })
  end,
}
