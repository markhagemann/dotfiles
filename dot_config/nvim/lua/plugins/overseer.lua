return {
  "stevearc/overseer.nvim",
  opts = {},
  config = function()
    require("overseer").setup({
      templates = { "register-shell-scripts", "builtin" },
      task_list = {
        bindings = {
          ["?"] = "ShowHelp",
          ["g?"] = "ShowHelp",
          ["<CR>"] = "RunAction",
          ["<C-e>"] = "Edit",
          ["o"] = false,
          ["<C-v>"] = false,
          ["<C-s>"] = false,
          ["<C-f>"] = false,
          ["<C-q>"] = false,
          ["p"] = "TogglePreview",
          ["<C-l>"] = "IncreaseDetail",
          ["<C-h>"] = "DecreaseDetail",
          ["L"] = "IncreaseAllDetail",
          ["H"] = "DecreaseAllDetail",
          ["["] = "DecreaseWidth",
          ["]"] = "IncreaseWidth",
          ["{"] = "PrevTask",
          ["}"] = "NextTask",
          ["<C-k>"] = "ScrollOutputUp",
          ["<C-j>"] = "ScrollOutputDown",
          ["q"] = "Close",
        },
      },
    })
  end,
  keys = {
    {
      "<leader>or",
      "<ESC><CMD>OverseerRun<CR>",
      mode = { "n", "t" },
      silent = true,
      desc = "Overseer run",
    },
    {
      "<leader>ot",
      "<ESC><CMD>OverseerToggle left<CR>",
      mode = { "n", "t" },
      silent = true,
      desc = "Overseer toggle",
    },
    {
      "<leader>oc",
      "<ESC><CMD>OverseerClose<CR>",
      mode = { "n", "t" },
      silent = true,
      desc = "Overseer close",
    },
  },
}
