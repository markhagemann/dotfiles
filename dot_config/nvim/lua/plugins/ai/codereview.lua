return {
  "afewyards/codereview.nvim",
  -- enabled = vim.env.ANTHROPIC_API_KEY,
  dependencies = { "nvim-lua/plenary.nvim" },
  cmd = {
    "CodeReview",
    "CodeReviewAI",
    "CodeReviewAIFile",
    "CodeReviewStart",
    "CodeReviewSubmit",
    "CodeReviewApprove",
    "CodeReviewOpen",
    "CodeReviewPipeline",
    "CodeReviewComments",
    "CodeReviewFiles",
  },
  opts = {
    ai = {
      enabled = false,
      provider = "anthropic",
      anthropic = { api_key = vim.env.ANTHROPIC_API_KEY },
    },
  },
}
