local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
  return
end

local config_status_ok, nvim_tree_config = pcall(require, "nvim-tree.config")
if not config_status_ok then
  return
end

local tree_cb = nvim_tree_config.nvim_tree_callback

nvim_tree.setup {
  git = {
    ignore = false,
  },
  update_focused_file = {
    enable = true,
    update_cwd = true,
  },
  renderer = {
    root_folder_modifier = ":t",
    icons = {
      glyphs = {
        default = "",
        symlink = "",
        folder = {
          arrow_open = "",
          arrow_closed = "",
          default = "",
          open = "",
          empty = "",
          empty_open = "",
          symlink = "",
          symlink_open = "",
        },
        git = {
          unstaged = "",
          staged = "S",
          unmerged = "",
          renamed = "➜",
          untracked = "U",
          deleted = "",
          ignored = "◌",
        },
      },
    },
  },
  diagnostics = {
    enable = true,
    show_on_dirs = true,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    },
  },
  view = {
    width = 30,
    side = "left",
    mappings = {
      list = {
        { key = { "<CR>", "o" }, cb = tree_cb("edit") },
        { key = "h", cb = tree_cb("dir_up") },
        { key = "l", cb = tree_cb("cd") },
        { key = "|", cb = tree_cb("vsplit") },
        { key = "-", cb = tree_cb("split") },
        { key = "<C-t>", cb = tree_cb("tabnew") },
        { key = "<Tab>", cb = tree_cb("preview") },
        { key = "K", cb = tree_cb("first_sibling") },
        { key = "J", cb = tree_cb("last_sibling") },
        { key = "<F5>", cb = tree_cb("refresh") },
        { key = { "n", "N" }, cb = tree_cb("create") },
        { key = { "d", "D" }, cb = tree_cb("remove") },
        { key = { "r", "R" }, cb = tree_cb("rename") },
        { key = "x", cb = tree_cb("cut") },
        { key = "c", cb = tree_cb("copy") },
        { key = "p", cb = tree_cb("paste") },
        { key = "y", cb = tree_cb("copy_name") },
        { key = "Y", cb = tree_cb("copy_path") },
        { key = "gy", cb = tree_cb("copy_absolute_path") },
        { key = "[c", cb = tree_cb("prev_git_item") },
        { key = "}c", cb = tree_cb("next_git_item") },
        { key = "q", cb = tree_cb("close") },
        { key = "g?", cb = tree_cb("toggle_help") },
      },
    },
  },
}
