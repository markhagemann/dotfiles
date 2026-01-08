return {
  -- Code formatter with auto-format on save and multiple formatter support
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    -- {
    --   "<leader>lf",
    --   ":Format<CR>",
    --   mode = "v",
    --   desc = "Lsp format range",
    -- },
    {
      "<leader>cfd",
      ":FormatDisable<CR>",
      mode = "n",
      desc = "disable formatting",
    },
    {
      "<leader>cfe",
      ":FormatEnable<CR>",
      mode = "n",
      desc = "enable formatting",
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

    ---Selects the first available formatter.
    ---
    ---@param bufnr integer
    ---@param ... string
    ---@return string
    local function first(bufnr, ...)
      local conform = require("conform")
      for i = 1, select("#", ...) do
        local formatter = select(i, ...)
        if conform.get_formatter_info(formatter, bufnr).available then
          return formatter
        end
      end
      return select(1, ...)
    end

    local function select_prettier(bufnr)
      return first(bufnr, "prettierd", "prettier")
    end

    local function use_prettier(bufnr)
      return { select_prettier(bufnr) }
    end

    local function use_web_formatters(bufnr)
      return { "eslint_d", select_prettier(bufnr) }
    end

    -- local sh_formatters = {
    --   "beautysh",
    -- }

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
        return { lsp_fallback = true, stop_after_first = true }
      end,
      formatters_by_ft = {
        -- bash = sh_formatters,
        css = use_web_formatters,
        html = use_prettier,
        lua = { "stylua" },
        go = { "goimports" },
        python = { "isort", "black" },
        javascript = use_web_formatters,
        -- sh = sh_formatters,
        typescript = use_web_formatters,
        typescriptreact = use_web_formatters,
        vue = use_web_formatters,
      },
    })
  end,
}
