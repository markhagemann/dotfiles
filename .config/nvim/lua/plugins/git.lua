return {
  {
    "lewis6991/gitsigns.nvim",
    event = "BufEnter",
    opts = {},
  },
  {
    "ThePrimeagen/git-worktree.nvim",
    event = "BufEnter",
    config = function()
      require("git-worktree").setup()
    end,
  },
}
