return {
  "nvimtools/none-ls.nvim",
  event = "BufReadPre",
  dependencies = { "mason.nvim" },
  opts = function()
    local nls = require("null-ls")
    return {
      sources = {
        -- nls.builtins.formatting.prettierd,
        nls.builtins.diagnostics.eslint_d.with({ -- js/ts linter
          -- only enable eslint if root has .eslintrc.js (not in youtube nvim video)
          condition = function(utils)
            return utils.root_has_file(".eslintrc.js") -- change file extension if you use something else
          end,
        }),
        nls.builtins.formatting.eslint_d,
        nls.builtins.formatting.stylua,
        nls.builtins.diagnostics.flake8,
      },
    }
  end,
}
