return {
  "saxon1964/neovim-tips",
  dependencies = { "ibhagwan/fzf-lua" },
  opts = {
    -- OPTIONAL: Location of user defined tips (default value shown below)
    user_file = vim.fn.stdpath("config") .. "/neovim_tips/user_tips.txt",
  },
  keys = {
    { "<leader>nto", ":NeovimTips<CR>", desc = "Neovim tips", mode = "n" },
    { "<leader>nte", ":NeovimTipsEdit<CR>", desc = "Edit your Neovim tips", mode = "n" },
    { "<leader>nta", ":NeovimTipsAdd<CR>", desc = "Add your Neovim tip", mode = "n" },
  },
}
