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
  {
    -- Bruno API client integration for Neovim
    "romek-codes/bruno.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "folke/snacks.nvim",
        opts = { picker = { enabled = true } },
      },
    },
    config = function()
      require("bruno").setup({
        -- Paths to your bruno collections.
        -- collection_paths = {
        --   { name = "Main", path = "/path/to/folder/containing/collections/Documents/Bruno" },
        -- },
        picker = "snacks",
        -- If output should be formatted by default.
        show_formatted_output = true,
        -- If formatting fails for whatever reason, don't show error message (will always fallback to unformatted output).
        suppress_formatting_errors = false,
      })
    end,
    keys = {
      { "<leader>br", "<cmd>BrunoRun<cr>", desc = "Bruno Run" },
      { "<leader>be", "<cmd>BrunoEnv<cr>", desc = "Bruno Environment" },
      { "<leader>bs", "<cmd>BrunoSearch<cr>", desc = "Bruno Search" },
      { "<leader>bt", "<cmd>BrunoToggleFormat<cr>", desc = "Bruno Toggle Format" },
    },
  },
  {
    -- cURL scratchpad for testing HTTP requests
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
