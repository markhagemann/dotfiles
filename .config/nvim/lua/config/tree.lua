vim.g.nvim_tree_ignore = { ".git", "node_modules" }
vim.g.nvim_tree_gitignore = 1
vim.g.nvim_tree_auto_open = 1
vim.g.nvim_tree_auto_close = 1
vim.g.nvim_tree_follow = 1
vim.g.nvim_tree_indent_markers = 1
vim.g.nvim_tree_git_hl = 1
vim.g.nvim_tree_disable_netrw = 0
vim.g.nvim_tree_lsp_diagnostics = 1

vim.g.nvim_tree_show_icons = {
  git = 1,
  folders = 1,
  files = 1
}

vim.g.nvim_tree_icons = {
  default = " ",
  symlink = " ",
  git = {
      unstaged = "",
      staged = "",
      unmerged = "",
      renamed = "➜",
      untracked = ""
  },
  folder = {
      default = "",
      open = "",
      symlink = ""
  }
}

local get_lua_cb = function(cb_name)
    return string.format(":lua require'nvim-tree'.on_keypress('%s')<CR>", cb_name)
end

local tree_cb = require'nvim-tree.config'.nvim_tree_callback
-- default mappings
vim.g.nvim_tree_bindings = {
  { key = {"<CR>", "o"},                  cb = tree_cb("edit") },
  { key = "h",                            cb = tree_cb("dir_up") },
  { key = "l",                            cb = tree_cb("cd") },
  { key = "|",                            cb = tree_cb("vsplit") },
  { key = "-",                            cb = tree_cb("split") },
  { key = "<C-t>",                        cb = tree_cb("tabnew") },
  { key = "<Tab>",                        cb = tree_cb("preview") },
  { key = "K",                            cb = tree_cb("first_sibling") },
  { key = "J",                            cb = tree_cb("last_sibling") },
  { key = ".",                            cb = tree_cb("toggle_ignored") },
  { key = "V",                            cb = tree_cb("toggle_dotfiles") },
  { key = "<F5>",                         cb = tree_cb("refresh") },
  { key = {"n", "N"},                     cb = tree_cb("create") },
  { key = {"d", "D"},                     cb = tree_cb("remove") },
  { key = {"r", "R"},                     cb = tree_cb("rename") },
  { key = "x",                            cb = tree_cb("cut") },
  { key = "c",                            cb = tree_cb("copy") },
  { key = "p",                            cb = tree_cb("paste") },
  { key = "y",                            cb = tree_cb("copy_name") },
  { key = "Y",                            cb = tree_cb("copy_path") },
  { key = "gy",                           cb = tree_cb("copy_absolute_path") },
  { key = "[c",                           cb = tree_cb("prev_git_item") },
  { key = "}c",                           cb = tree_cb("next_git_item") },
  { key = "q",                            cb = tree_cb("close") },
  { key = "g?",                           cb = tree_cb("toggle_help") },
}

require("nvim-tree.events").on_nvim_tree_ready(function()
  vim.cmd("NvimTreeRefresh")
end)
