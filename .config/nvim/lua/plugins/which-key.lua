return {
  {
    "folke/which-key.nvim",
    event = "VimEnter", -- Sets the loading event to 'VimEnter'
    opts = {
      mode = "n",
      plugins = {
        presets = {
          operators = false,
        }
      },
      window = {
        border = "single",   -- none, single, double, shadow
        position = "bottom", -- bottom, top
        zindex = 1000,       -- positive value to position WhichKey above other floating windows.
      },
    },
    config = function(_, opts) -- This is the function that runs, AFTER loading
      require("which-key").setup(opts or {})

      -- Document existing key chains
      require("which-key").register({
        ["<leader>c"] = { name = "[C]ode", _ = "which_key_ignore" },
        ["<leader>d"] = { name = "[D]ocument", _ = "which_key_ignore" },
        ["<leader>r"] = { name = "[R]ename", _ = "which_key_ignore" },
        ["<leader>s"] = { name = "[S]earch", _ = "which_key_ignore" },
        ["<leader>w"] = { name = "[W]orkspace", _ = "which_key_ignore" },
      })
    end,
  },
}
