return {
  "GeorgesAlkhouri/nvim-aider",
  cmd = "Aider",
  enabled = vim.env.ENABLE_AI_PLUGINS == true,
  keys = {
    { "<leader>a/", "<cmd>Aider toggle<cr>", desc = "aider toggle" },
    { "<leader>as", "<cmd>Aider send<cr>", desc = "aider send", mode = { "n", "v" } },
    { "<leader>ac", "<cmd>Aider command<cr>", desc = "aider commands" },
    { "<leader>ab", "<cmd>Aider buffer<cr>", desc = "aider send buffer" },
    { "<leader>a+", "<cmd>Aider add<cr>", desc = "aider add file" },
    { "<leader>a-", "<cmd>Aider drop<cr>", desc = "aider drop file" },
    { "<leader>ar", "<cmd>Aider add readonly<cr>", desc = "aider add read-only" },
    { "<leader>aR", "<cmd>Aider reset<cr>", desc = "aider reset session" },
  },
  dependencies = {
    "folke/snacks.nvim",
  },
  config = true,
}
