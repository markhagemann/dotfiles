return {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "nvimtools/none-ls-extras.nvim",
  },
  keys = {
    { "<leader>lf", vim.lsp.buf.format, {}, desc = "[L]SP [F]ormat Buffer" },
  },
  config = function()
    local null_ls = require("null-ls")
    null_ls.setup({
      debug = true,
      sources = {
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.prettier,
        require("none-ls.diagnostics.eslint"),
        require("none-ls.code_actions.eslint"),
      },
    })
  end,
}
