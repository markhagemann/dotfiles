return {
  {
    -- GitHub Copilot chat integration for AI-powered code assistance
    -- enabled = vim.env.ENABLE_GITHUB_COPILOT == "true",
    enabled = false,
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      {
        -- GitHub Copilot core plugin for code suggestions
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        build = ":Copilot auth",
        event = "BufReadPost",
        opts = {
          suggestion = {
            enabled = not vim.g.ai_cmp,
            auto_trigger = true,
            hide_during_completion = vim.g.ai_cmp,
            keymap = {
              accept = "<c-j>",
              next = "<M-]>",
              prev = "<M-[>",
            },
          },
          panel = { enabled = false },
          filetypes = {
            markdown = true,
            help = true,
          },
        },
      },
      -- Utility library for Neovim plugins (for curl, log and async functions)
      { "nvim-lua/plenary.nvim", branch = "master" },
    },
    build = "make tiktoken", -- Only on MacOS or Linux
    opts = {
      mappings = {
        complete = {
          insert = "<CR>",
        },
      },
    },
    keys = {
      { "<leader>at", "<cmd>CopilotChatToggle<cr>", mode = "n", desc = "AI: Copilot Chat Toggle" },
      { "<leader>ae", "<cmd>CopilotChatExplain<cr>", mode = "v", desc = "AI: Copilot Explain" },
      { "<leader>ar", "<cmd>CopilotChatReview<cr>", mode = "v", desc = "AI: Copilot Review" },
      { "<leader>af", "<cmd>CopilotChatFix<cr>", mode = "v", desc = "AI: Fix Code" },
      { "<leader>ao", "<cmd>CopilotChatOptimize<cr>", mode = "v", desc = "AI: Optimize Code" },
      { "<leader>agd", "<cmd>CopilotChatOptimize<cr>", mode = "v", desc = "AI: Generate Docs" },
      { "<leader>agt", "<cmd>CopilotChatOptimize<cr>", mode = "v", desc = "AI: Generate Tests" },
      { "<leader>apr", ":CopilotPrReview<cr>", "AI: PR review" },
    },
  },
}
