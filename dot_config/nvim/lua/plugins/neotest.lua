return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      { "nvim-treesitter/nvim-treesitter", branch = "main" },
      "marilari88/neotest-vitest",
      {
        "fredrikaverpil/neotest-golang",
        version = "*",
        dependencies = {
          "andythigpen/nvim-coverage", -- Added dependency
        },
      },
    },
    config = function()
      local neotest_golang_opts = { -- Specify configuration
        runner = "go",
        go_test_args = {
          "-v",
          "-race",
          "-count=1",
          "-coverprofile=" .. vim.fn.getcwd() .. "/coverage.out",
        },
      }
      require("neotest").setup({
        adapters = {
          require("neotest-golang")(neotest_golang_opts), -- Registration
          require("neotest-vitest"),
        },
      })
    end,
    keys = {
      { "<leader>ntr", "<cmd>Neotest run<cr>", desc = "Neotest Run" },
      { "<leader>nto", "<cmd>Neotest output<cr>", desc = "Neotest Output" },
      { "<leader>nts", "<cmd>Neotest summary<cr>", desc = "Neotest Summary" },
    },
  },
}
