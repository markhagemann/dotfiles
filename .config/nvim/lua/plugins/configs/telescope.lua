local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end

telescope.setup {
  defaults = {
    -- prompt_prefix = " ",
    -- selection_caret = " ",
    -- file_ignore_patterns = { ".git/", "node_modules" },
    file_ignore_patterns = { "yarn.lock" }
  },
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = false,
      override_file_sorter = true,
      case_mode = "smart_case"
    },
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
        }
      }
    }
  }
}
