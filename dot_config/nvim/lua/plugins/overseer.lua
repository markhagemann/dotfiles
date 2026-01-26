return {
  -- Task runner and job management system for Neovim
  "stevearc/overseer.nvim",
  branch = "master",
  -- commit = "c77c78b35d0b4d244e1cd77c25ec93a16fbbfc94",
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
      desc = "Overseer Run",
    },
    {
      "<leader>ot",
      "<ESC><CMD>OverseerTaskAction<CR>",
      mode = { "n", "t" },
      silent = true,
      desc = "Overseer Task Action",
    },
    {
      "<leader>ot",
      "<ESC><CMD>OverseerToggle left<CR>",
      mode = { "n", "t" },
      silent = true,
      desc = "Overseer Dashboard",
    },
    {
      "<leader>oc",
      "<ESC><CMD>OverseerClose<CR>",
      mode = { "n", "t" },
      silent = true,
      desc = "Overseer close",
    },
    {
      "<leader>ol",
      function()
        vim.cmd("tabnew ~/.local/state/nvim/overseer.log")
      end,
      mode = { "n" },
      desc = "Open Overseer log",
    },
  },
}
