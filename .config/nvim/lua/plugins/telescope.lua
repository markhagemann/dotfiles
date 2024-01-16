local keymap = vim.keymap


keymap.set("n", "<C-p>", "<CMD>Telescope find_files<CR>") --- find files within current working directory-
-- keymap.set(
--   "n",
--   "<C-p>",
--   "<cmd>lua require'telescope.builtin'.find_files({ find_command = {'rg', '--files', '--hidden', '-g', '!.git' }})<cr>"
-- )                                               -- find files within current working directory
keymap.set("n", "<leader>/", "<CMD>Telescope live_grep<CR>") -- find string in current working directory as you type
keymap.set("n", "<leader>.", "<CMD>Telescope grep_string<CR>") -- find string under cursor in current working directory
keymap.set("n", "<leader>,", "<CMD>Telescope buffers<CR>") -- list open buffers in current neovim instance
keymap.set("n", "<leader>ht", "<CMD>Telescope help_tags<CR>") -- list available help tags
keymap.set("n", "<leader>u", "<CMD>Telescope undo<CR>")
keymap.set("n", "<Leader>cw", "<CMD>lua require('telescope').extensions.git_worktree.create_git_worktree()<CR>")
keymap.set("n", "<Leader>vw", "<CMD>lua require('telescope').extensions.git_worktree.git_worktrees()<CR>")

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
        defaults = {
          file_sorter = require("telescope.sorters").get_fzy_sorter,
          path_display = { truncate = 3 },
        },
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
      require("telescope").load_extension("git_worktree")
    end,
  },
}
