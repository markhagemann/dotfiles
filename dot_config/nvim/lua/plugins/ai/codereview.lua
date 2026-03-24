return {
  "afewyards/codereview.nvim",
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
      enabled = vim.env.CODEREVIEW_AI_PROVIDER ~= nil,
      provider = vim.env.CODEREVIEW_AI_PROVIDER,
    },
  },
}
