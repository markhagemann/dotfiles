return {
  "stevearc/overseer.nvim",
  opts = {},
  config = function()
    require("overseer").setup({
      templates = { "register-shell-scripts", "builtin" },
    })
  end,
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
      "<ESC><CMD>OverseerToggle left<CR>",
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
