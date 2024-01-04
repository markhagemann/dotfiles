local builtin = require("telescope.builtin")
local keymap = vim.keymap

keymap.set(
  "n",
  "<C-p>",
  "<cmd>lua require'telescope.builtin'.find_files({ find_command = {'rg', '--files', '--hidden', '-g', '!.git' }})<cr>"
) -- find files within current working directory
keymap.set("n", "<leader>/", builtin.live_grep, {}) -- find string in current working directory as you type
keymap.set("n", "<leader>.", builtin.grep_string, {}) -- find string under cursor in current working directory
keymap.set("n", "<leader>,", builtin.buffers, {}) -- list open buffers in current neovim instance
keymap.set("n", "<leader>ht", builtin.help_tags, {}) -- list available help tags
keymap.set("n", "<leader>u", "<cmd>Telescope undo<cr>")

return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "nvim-telescope/telescope-fzy-native.nvim",
      -- { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      "debugloop/telescope-undo.nvim",
    },
    cmd = "Telescope",
    tag = "0.1.5",
    config = function()
      require("telescope").setup({
        extensions = {
          extensions = {
            fzy_native = {
              override_generic_sorter = false,
              override_file_sorter = true,
            },
          },
          -- fzf = {
          --   fuzzy = true,                   -- false will only do exact matching
          --   override_generic_sorter = true, -- override the generic sorter
          --   override_file_sorter = true,    -- override the file sorter
          --   case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
          -- },
          undo = {},
        },
      })

      require("telescope").load_extension("fzy_native")
      require("telescope").load_extension("undo")
    end,
  },
}
