-- local filetypes =
--   { "go", "javascript", "python", "typescript", "typescriptreact", "vue", "html", "css", "sh", "terraform", "markdown" }

return {
  "https://gitlab.com/gitlab-org/editor-extensions/gitlab.vim.git",
  event = { "BufReadPre", "BufNewFile" },
  -- ft = filetypes,
  enabled = vim.env.ENABLE_GITLAB_DUO == "true" and vim.env.GITLAB_TOKEN and vim.env.GITLAB_TOKEN ~= "",
  config = function()
    require("gitlab").setup({
      statusline = {
        enabled = false,
      },
      telemetry = {
        enabled = false,
      },
      token = vim.env.GITLAB_TOKEN,
      base_url = "https://gitlab.com",
      code_suggestions = {
        enabled = true,
        -- auto_filetypes = filetypes,
        ghost_text = {
          enabled = true,
          accept_suggestion = "<C-j>",
          stream = true,
        },
      },
    })
  end,
}
