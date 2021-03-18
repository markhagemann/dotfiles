local action_state = require('telescope.actions.state')
local actions = require('telescope.actions')

local m = {}
m.my_buffer = function()
  require('telescope.builtin').buffers{
    attach_mappings = function(prompt_bufnr, map)
      local delete_buf = function()
        local selection = action_state.get_selected_entry()
        vim.api.nvim_buf_delete(selection.bufnr, { force = false })
        actions.close(prompt_bufnr)
      end

      -- mode, key, func
      -- this is just an example
      map('n', 'd', delete_buf)

      return true
    end
  }
end
return m
