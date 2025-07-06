return {
  "azorng/goose.nvim",
  -- enabled = vim.env.ENABLE_AI_PLUGINS == "true",
  enabled = false,
  config = function()
    require("goose").setup({
      providers = {
        openrouter = {
          -- "meta-llama/llama-4-maverick",
          "mistralai/mistral-nemo",
        },
      },
    })
  end,
  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      "MeanderingProgrammer/render-markdown.nvim",
      opts = {
        anti_conceal = { enabled = false },
      },
    },
  },

  keys = {
    { "<leader>at", "<Cmd>lua require('goose.api').toggle()<CR>", desc = "Ai toggle" },
  },
}
