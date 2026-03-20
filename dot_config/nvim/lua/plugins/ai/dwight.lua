return {
  "otaleghani/dwight.nvim",
  enabled = vim.env.DWIGHT_BACKEND ~= nil,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    require("dwight").setup({
      backend = vim.env.DWIGHT_BACKEND,
    })
  end,
  keys = {
    -- Plan and execute multi-step tasks automatically
    { "<leader>aa", "<cmd>DwightAuto<cr>", mode = { "n", "v" }, desc = "AI: Dwight Auto (plan & execute)" },
    -- Select code and pick editing modes (/refactor, /test, /fix)
    { "<leader>ai", "<cmd>DwightInvoke<cr>", mode = { "n", "v" }, desc = "AI: Dwight Invoke (edit modes)" },
    -- Run autonomous single-task with tool use
    { "<leader>at", "<cmd>DwightAgent<cr>", mode = { "n", "v" }, desc = "AI: Dwight Agent (single task)" },
    -- Browse, preview, and split features
    { "<leader>af", "<cmd>DwightFeatures<cr>", desc = "AI: Dwight Features" },
    -- Decompose large refactoring into steps
    { "<leader>ar", "<cmd>DwightRefactor<cr>", mode = { "n", "v" }, desc = "AI: Dwight Refactor" },
    -- Check session diffs for review
    { "<leader>ad", "<cmd>DwightDiffReview<cr>", desc = "AI: Dwight Diff Review" },
    -- Smart commits and diff review
    { "<leader>aG", "<cmd>DwightGit<cr>", desc = "AI: Dwight Git" },
    -- AI brainstorming scratchpad
    { "<leader>aw", "<cmd>DwightWhiteboard<cr>", desc = "AI: Dwight Whiteboard" },
    -- Parallel multi-agent waves across worktrees
    { "<leader>aS", "<cmd>DwightSwarm<cr>", desc = "AI: Dwight Swarm" },
    -- Test-driven development loop
    { "<leader>aT", "<cmd>DwightTDD<cr>", desc = "AI: Dwight TDD" },
    -- Find and fix quality issues
    { "<leader>aA", "<cmd>DwightAudit<cr>", desc = "AI: Dwight Audit" },
    -- Generate pull requests
    -- { "<leader>aP", "<cmd>DwightPR<cr>", desc = "AI: Dwight PR" },
  },
}
