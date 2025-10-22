return {
  enabled = vim.env.ENABLE_OPENCODE == "true",
  "NickvanDyke/opencode.nvim",
  dependencies = {
    "folke/snacks.nvim",
    {
      "zbirenbaum/copilot.lua",
      enabled = vim.env.ENABLE_COPILOT == "true",
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
  },
  ---@type opencode.Config
  opts = {
    -- Your configuration, if any
  },
  -- stylua: ignore
  keys = {
    { '<leader>at', function() require('opencode').toggle() end, desc = 'AI: Toggle embedded opencode', },
    { '<leader>aa', function() require('opencode').ask() end, desc = 'AI: Ask opencode', mode = 'n', },
    { '<leader>as', function() require('opencode').ask('@selection: ') end, desc = 'AI: Ask opencode about selection', mode = 'v', },
    { '<leader>ap', function() require('opencode').select_prompt() end, desc = 'AI: Select prompt', mode = { 'n', 'v', }, },
    { '<leader>an', function() require('opencode').command('session_new') end, desc = 'AI: New session', },
    { '<leader>ay', function() require('opencode').command('messages_copy') end, desc = 'AI: Copy last message', },
    { '<S-C-j>',    function() require('opencode').command('messages_half_page_up') end, desc = 'AI: Scroll messages up', },
    { '<S-C-k>',    function() require('opencode').command('messages_half_page_down') end, desc = 'AI: Scroll messages down', },
  },
}
