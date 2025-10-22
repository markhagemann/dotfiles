return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-neotest/neotest-go",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  opts = {
    adapters = {
      ["neotest-go"] = {
        -- Here we can set options for neotest-go, e.g.
        -- args = { "-tags=integration" }
        recursive_run = true,
      },
    },
    log_level = vim.log.levels.DEBUG,
  },
  keys = {
    -- Run nearest tests
    vim.keymap.set("n", "<leader>rn", function()
      require("neotest").run.run()
    end, { desc = "Run nearest tests" }),
    -- Run tests in file
    vim.keymap.set("n", "<leader>rf", function()
      require("neotest").run.run(vim.fn.expand("%"))
    end, { desc = "Run tests in file" }),
  },
}
