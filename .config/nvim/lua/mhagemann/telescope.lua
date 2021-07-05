local action_state = require('telescope.actions.state')
local actions = require('telescope.actions')

local m = {}
m.my_buffer = function()
  opts = {}
  opts.attach_mappings = function(prompt_bufnr, map)
    local delete_buf = function()
      local selection = action_state.get_selected_entry()
      actions.close(prompt_bufnr)
      vim.api.nvim_buf_delete(selection.bufnr, { force = true })
    end
    map('n', '<C-x>', delete_buf)
    map('i', '<C-x>', delete_buf)
    return true
  end
  opts.previewer = false
  opts.initial_mode = 'normal'
  -- define more opts here
  -- opts.show_all_buffers = true
  -- opts.sort_lastused = true
  -- opts.shorten_path = false
  require('telescope.builtin').buffers(require('telescope.themes').get_dropdown(opts))
end
return m
