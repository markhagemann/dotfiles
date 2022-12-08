local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
	return
end

telescope.setup({
	defaults = {
		prompt_prefix = " ",
		selection_caret = " ",
		path_display = { "smart" },
		file_ignore_patterns = { ".git/", "node_modules" },
	},

	pickers = {
		buffers = {
			show_all_buffers = true,
			sort_lastused = true,
			-- theme = "dropdown",
			-- previewer = false,
			mappings = {
				i = {
					["<M-d>"] = "delete_buffer",
				},
			},
		},
	},
})
