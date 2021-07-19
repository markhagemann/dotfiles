require("bufferline").setup({
  highlights = {
    buffer_selected = {
      gui = "bold"
    },
    diagnostic_selected = {
      gui = "bold"
    },
    error_diagnostic_selected = {
      gui = "bold"
    },
    error_selected = {
      gui = "bold"
    },
    info_diagnostic_selected = {
      gui = "bold"
    },
    info_selected = {
      gui = "bold"
    },
    warning_selected = {
      gui = "bold"
    },
    warning_diagnostic_selected = {
      gui = "bold"
    },
  },
  options = {
    mappings = true,
    show_close_icon = true,
    diagnostics = "nvim_lsp",
    always_show_bufferline = false,
    separator_style = "slant",
    diagnostics_indicator = function(count, level, diagnostics_dict, context)
      return "("..count..")"
    end,
    -- diagnostics_indicator = function(_, _, diagnostics_dict)
    --   local s = " "
    --   for e, n in pairs(diagnostics_dict) do
    --     local sym = e == "error" and " " or (e == "warning" and " " or "")
    --     s = s .. sym .. n
    --   end
    --   return s
    -- end,
  },
})
