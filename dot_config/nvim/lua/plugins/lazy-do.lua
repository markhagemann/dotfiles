return {
  "Dan7h3x/LazyDo",
  branch = "main",
  cmd = { "LazyDoToggle", "LazyDoPin" },
  keys = {
    {
      "<leader>tl",
      "<ESC><CMD>LazyDoToggle<CR>",
      mode = { "n" },
      silent = true,
      desc = "toggle lazydo",
    },
  },
  event = "VeryLazy",
  opts = {
    -- your config here
  },
}
