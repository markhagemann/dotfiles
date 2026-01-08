return {
  -- Lazydocker terminal UI integration for Docker management
  "crnvl96/lazydocker.nvim",
  opts = {
    window = {
      settings = {
        width = 1, -- Percentage of screen width (0 to 1)
        height = 1, -- Percentage of screen height (0 to 1)
        border = "rounded", -- See ':h nvim_open_win' border options
        relative = "editor", -- See ':h nvim_open_win' relative options
      },
    },
  },
  keys = {
    {
      "<leader>ld",
      function()
        require("lazydocker").toggle()
      end,
      desc = "Lazydocker",
    },
  },
}
