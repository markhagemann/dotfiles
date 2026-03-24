return {
  {
    -- HTTP client for making requests from Neovim
    "mistweaverco/kulala.nvim",
    enabled = false,
    keys = {
      { "<leader>hs", desc = "Send http request" },
      { "<leader>ha", desc = "Send all http requests" },
      { "<leader>hb", desc = "Open http scratchpad" },
    },
    ft = { "http", "rest" },
    opts = {
      debug = true,
      global_keymaps = true,
      global_keymaps_prefix = "<leader>h",
      kulala_keymaps_prefix = "",
    },
  },
}
