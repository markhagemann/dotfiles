return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      preset = "helix",
    },
  },
  -- {
  --   config = function(_, opts) -- This is the function that runs, AFTER loading
  --     require("which-key").setup(opts or {})
  --
  --     -- Document existing key chains
  --     -- require("which-key").add({
  --     --   ["<leader>c"] = { name = "Code", _ = "which_key_ignore" },
  --     --   ["<leader>d"] = { name = "Document", _ = "which_key_ignore" },
  --     --   ["<leader>r"] = { name = "Rename", _ = "which_key_ignore" },
  --     --   ["<leader>s"] = { name = "Search", _ = "which_key_ignore" },
  --     --   ["<leader>w"] = { name = "Workspace", _ = "which_key_ignore" },
  --     -- })
  --   end,
  -- },
}
