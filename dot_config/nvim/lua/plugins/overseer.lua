return {
  "stevearc/overseer.nvim",
  opts = {},

  keys = {
    {
      "<leader>or",
      "<ESC><CMD>OverseerRun<CR>",
      mode = { "n", "t" },
      silent = true,
      desc = "overseer run",
    },
    {
      "<leader>ot",
      "<ESC><CMD>OverseerToggle<CR>",
      mode = { "n", "t" },
      silent = true,
      desc = "overseer toggle",
    },
    {
      "<leader>oc",
      "<ESC><CMD>OverseerClose<CR>",
      mode = { "n", "t" },
      silent = true,
      desc = "overseer close",
    },
  },
}
