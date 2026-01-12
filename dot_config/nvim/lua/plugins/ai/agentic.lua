return {
  -- AI coding assistant that makes use of ACP
  "carlos-algms/agentic.nvim",
  enabled = vim.env.ENABLE_AGENTIC == "true",
  opts = {
    provider = vim.env.AGENTIC_PROVIDER or "cursor-acp",
  },
  keys = {
    {
      "<leader>at",
      function()
        require("agentic").toggle()
      end,
      mode = { "n", "v", "i" },
      desc = "AI: Toggle Agentic Chat",
    },
    {
      "<leader>af",
      function()
        require("agentic").add_selection_or_file_to_context()
      end,
      mode = { "n", "v" },
      desc = "AI: Add file or selection to Agentic to Context",
    },
    {
      "<leader>an",
      function()
        require("agentic").new_session()
      end,
      mode = { "n", "v", "i" },
      desc = "New Agentic Session",
    },
  },
}
