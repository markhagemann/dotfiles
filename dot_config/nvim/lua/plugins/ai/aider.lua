return {
  "GeorgesAlkhouri/nvim-aider",
  cmd = "Aider",
  -- enabled = vim.env.ENABLE_AI_PLUGINS == "true",
  enabled = false,
  keys = {
    { "<leader>at", "<cmd>Aider toggle<cr>", desc = "Aider toggle" },
    { "<leader>as", "<cmd>Aider send<cr>", desc = "Aider send", mode = { "n", "v" } },
    { "<leader>ac", "<cmd>Aider command<cr>", desc = "Aider commands" },
    { "<leader>ab", "<cmd>Aider buffer<cr>", desc = "Aider send buffer" },
    { "<leader>a+", "<cmd>Aider add<cr>", desc = "Aider add file" },
    { "<leader>a-", "<cmd>Aider drop<cr>", desc = "Aider drop file" },
    { "<leader>ar", "<cmd>Aider add readonly<cr>", desc = "Aider add read-only" },
    { "<leader>aR", "<cmd>Aider reset<cr>", desc = "Aider reset session" },
  },
  dependencies = {
    "folke/snacks.nvim",
  },
  config = true,
}
