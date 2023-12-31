return {
  {
    "catppuccin/nvim",
    lazy = false,
    name = "catppuccin",
    priority = 1000,
    config = function()
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
