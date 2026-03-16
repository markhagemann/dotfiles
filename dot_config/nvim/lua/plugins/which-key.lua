return {
  {
    -- Keybinding helper showing available keymaps in a popup
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      preset = "helix",
      -- https://github.com/folke/which-key.nvim?tab=readme-ov-file#%EF%B8%8F-configuration
    },
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false, preset = "helix" })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
  },
}
