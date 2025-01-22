return {
  "Dan7h3x/LazyDo",
  branch = "main",
  cmd = { "LazyDoToggle", "LazyDoPin" },
  keys = {
    {
      "<leader>lt",
      "<ESC><CMD>LazyDoToggle<CR>",
      mode = { "n", "i" },
    },
  },
  event = "VeryLazy",
  opts = {
    -- your config here
  },
}
