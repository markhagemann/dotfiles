return {
  {
    "harrisoncramer/gitlab.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
      "stevearc/dressing.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    enabled = true,
    build = function()
      require("gitlab.server").build(true)
    end, -- Builds the Go binary
    config = function()
      require("gitlab").setup()
    end,
  },
  -- {
  --   "lewis6991/gitsigns.nvim",
  --   event = "BufEnter",
  --   config = function()
  --     require("gitsigns").setup({
  --       current_line_blame = true,
  --       current_line_blame_opts = {
  --         virt_text = true,
  --         virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
  --         delay = 1000,
  --         ignore_whitespace = false,
  --         virt_text_priority = 100,
  --       },
  --     })
  --   end,
  -- },
  {
    "ThePrimeagen/git-worktree.nvim",
    event = "BufEnter",
    config = function()
      require("git-worktree").setup()
    end,
  },
}
