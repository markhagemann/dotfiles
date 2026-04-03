return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lint = require("lint")
    lint.linters_by_ft = {
      javascript = { "eslint_d" },
      typescript = { "eslint_d" },
      javascriptreact = { "eslint_d" },
      typescriptreact = { "eslint_d" },
      vue = { "eslint_d" },
    }

    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
    local timer = (vim.uv or vim.loop).new_timer()

    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "TextChanged", "TextChangedI" }, {
      group = lint_augroup,
      callback = function()
        timer:stop()
        timer:start(
          500,
          0,
          vim.schedule_wrap(function()
            lint.try_lint()
          end)
        )
      end,
    })
  end,
}
