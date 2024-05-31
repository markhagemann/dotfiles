local js_formatters = {
  "eslint_d",
  { "prettierd", "prettier" },
}

local sh_formatters = {
  "beautysh",
}

return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    -- {
    --   "<leader>lf",
    --   ":Format<CR>",
    --   mode = "v",
    --   desc = "[L]SP [F]ormat Range",
    -- },
    {
      "<leader>ldf",
      ":FormatDisable<CR>",
      mode = "n",
      desc = "[L]SP [D]isable Formatting",
    },
    {
      "<leader>lef",
      ":FormatEnable<CR>",
      mode = "n",
      desc = "[L]SP [E]nable Formatting",
    },
  },
  init = function()
    vim.api.nvim_create_user_command("FormatDisable", function(args)
      vim.g.disable_autoformat = true
    end, {
      desc = "Disable autoformat-on-save",
    })

    vim.api.nvim_create_user_command("FormatEnable", function()
      vim.g.disable_autoformat = false
    end, {
      desc = "Re-enable autoformat-on-save",
    })

    require("conform").setup({
      format_after_save = function(bufnr)
        -- Disable autoformat on certain filetypes
        local ignore_filetypes = { "sql" }
        if vim.tbl_contains(ignore_filetypes, vim.bo[bufnr].filetype) then
          return
        end
        -- Disable with a global or buffer-local variable
        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
          return
        end
        -- Disable autoformat for files in a certain path
        local bufname = vim.api.nvim_buf_get_name(bufnr)
        if bufname:match("/node_modules/") then
          return
        end
        return { lsp_fallback = true }
      end,
      formatters_by_ft = {
        bash = sh_formatters,
        lua = { "stylua" },
        python = { "isort", "black" },
        javascript = js_formatters,
        sh = sh_formatters,
        typescript = js_formatters,
        vue = js_formatters,
      },
    })
  end,
}
