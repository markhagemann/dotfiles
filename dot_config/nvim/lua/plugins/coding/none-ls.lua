return {
  -- LSP diagnostics and code actions using external tools (ESLint, etc.)
  "nvimtools/none-ls.nvim",
  event = "LspAttach",
  dependencies = {
    "nvimtools/none-ls-extras.nvim",
  },
  config = function()
    local null_ls = require("null-ls")
    local eslint_d_opts = {
      allow_incremental_sync = false,
      debounce_text_changes = 1000,
    }
    null_ls.setup({
      debug = false,
      sources = {
        require("none-ls.diagnostics.eslint_d").with(eslint_d_opts),
        require("none-ls.code_actions.eslint_d").with(eslint_d_opts),
      },
    })
  end,
}
