return {
  {
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
  {
    "oysandvik94/curl.nvim",
    cmd = { "CurlOpen" },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    keys = {
      { "<leader>hcs", "<cmd>CurlOpen<cr>", desc = "Open curl scratchpad" },
      { "<leader>hcc", "<cmd>CurlClose<cr>", desc = "Close curl scratchpad" },
    },
    config = true,
  },
}
