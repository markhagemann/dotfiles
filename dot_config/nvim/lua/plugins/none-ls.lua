return {
  "nvimtools/none-ls.nvim",
  enabled = false,
  event = "LspAttach",
  dependencies = {
    "nvimtools/none-ls-extras.nvim",
  },
  config = function()
    local null_ls = require("null-ls")
    null_ls.setup({
      debug = false,
      sources = {
        require("none-ls.diagnostics.eslint_d"),
        require("none-ls.code_actions.eslint_d"),
      },
    })
  end,
}
