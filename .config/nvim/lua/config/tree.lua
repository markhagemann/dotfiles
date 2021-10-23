-- vim.g.nvim_tree_ignore = { ".git", "node_modules" }
-- vim.g.nvim_tree_gitignore = 1
-- vim.g.nvim_tree_auto_open = 1
-- vim.g.nvim_tree_auto_close = 1
-- vim.g.nvim_tree_follow = 1
-- vim.g.nvim_tree_auto_ignore_ft = { "dashboard", "startify" }
-- vim.g.nvim_tree_indent_markers = 1
-- vim.g.nvim_tree_git_hl = 1
-- vim.g.nvim_tree_disable_netrw = 0
-- vim.g.nvim_tree_lsp_diagnostics = 1

require("nvim-tree.events").on_nvim_tree_ready(function()
	vim.cmd("NvimTreeRefresh")
end)

-- following options are the default
require("nvim-tree").setup({
	-- disables netrw completely
	disable_netrw = true,
	-- hijack netrw window on startup
	hijack_netrw = true,
	-- open the tree when running this setup function
	open_on_setup = false,
	-- will not open on setup if the filetype is in this list
	ignore_ft_on_setup = {},
	-- closes neovim automatically when the tree is the last **WINDOW** in the view
	auto_close = false,
	-- opens the tree when changing/opening a new tab if the tree wasn't previously opened
	open_on_tab = false,
	-- hijacks new directory buffers when they are opened.
	update_to_buf_dir = {
		-- enable the feature
		enable = true,
		-- allow to open the tree if it was previously closed
		auto_open = true,
	},
	-- hijack the cursor in the tree to put it at the start of the filename
	hijack_cursor = false,
	-- updates the root directory of the tree on `DirChanged` (when your run `:cd` usually)
	update_cwd = false,
	-- show lsp diagnostics in the signcolumn
	diagnostics = {
		enable = false,
		icons = {
			hint = "",
			info = "",
			warning = "",
			error = "",
		},
	},
	-- update the focused file on `BufEnter`, un-collapses the folders recursively until it finds the file
	update_focused_file = {
		-- enables the feature
		enable = false,
		-- update the root directory of the tree to the one of the folder containing the file if the file is not under the current root directory
		-- only relevant when `update_focused_file.enable` is true
		update_cwd = false,
		-- list of buffer names / filetypes that will not update the cwd if the file isn't found under the current root directory
		-- only relevant when `update_focused_file.update_cwd` is true and `update_focused_file.enable` is true
		ignore_list = {},
	},
	-- configuration options for the system open command (`s` in the tree by default)
	system_open = {
		-- the command to run this, leaving nil should work in most cases
		cmd = nil,
		-- the command arguments as a list
		args = {},
	},

	view = {
		-- width of the window, can be either a number (columns) or a string in `%`, for left or right side placement
		width = 30,
		-- height of the window, can be either a number (columns) or a string in `%`, for top or bottom side placement
		height = 30,
		-- side of the tree, can be one of 'left' | 'right' | 'top' | 'bottom'
		side = "left",
		-- if true the tree will resize itself after opening a file
		auto_resize = false,
		mappings = {
			-- custom only false will merge the list with the default mappings
			-- if true, it will only use your list to set the mappings
			custom_only = false,
			-- list of mappings to set on the tree manually
			list = {},
		},
	},
})
local tree_cb = require("nvim-tree.config").nvim_tree_callback
-- default mappings
vim.g.nvim_tree_bindings = {
	{ key = { "<CR>", "o" }, cb = tree_cb("edit") },
	{ key = "h", cb = tree_cb("dir_up") },
	{ key = "l", cb = tree_cb("cd") },
	{ key = "|", cb = tree_cb("vsplit") },
	{ key = "-", cb = tree_cb("split") },
	{ key = "<C-t>", cb = tree_cb("tabnew") },
	{ key = "<Tab>", cb = tree_cb("preview") },
	{ key = "K", cb = tree_cb("first_sibling") },
	{ key = "J", cb = tree_cb("last_sibling") },
	{ key = ".", cb = tree_cb("toggle_ignored") },
	{ key = "V", cb = tree_cb("toggle_dotfiles") },
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
}
