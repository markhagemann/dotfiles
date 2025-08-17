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
    "romek-codes/bruno.nvim",
    enabled = false,
    dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
    config = function()
      require("bruno").setup({
        -- Paths to your bruno collections.
        -- collection_paths = {
        --   { name = "Main", path = "/path/to/folder/containing/collections/Documents/Bruno" },
        -- },
        -- If output should be formatted by default.
        show_formatted_output = true,
        -- If formatting fails for whatever reason, don't show error message (will always fallback to unformatted output).
        suppress_formatting_errors = false,
      })
    end,
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
