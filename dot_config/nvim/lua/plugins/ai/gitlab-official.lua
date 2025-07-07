local filetypes =
  { "go", "javascript", "python", "typescript", "typescriptreact", "vue", "html", "css", "sh", "terraform", "markdown" }

return {
  "https://gitlab.com/gitlab-org/editor-extensions/gitlab.vim.git",
  event = { "BufEnter" },
  ft = filetypes,
  enabled = vim.env.ENABLE_GITLAB_DUO == "true" and vim.env.GITLAB_TOKEN and vim.env.GITLAB_TOKEN ~= "",
  config = function()
    -- Setup the plugin with the provided options
    require("gitlab").setup({
      minimal_message_level = vim.log.levels.WARN,
      statusline = {
        enabled = false,
      },
      token = vim.env.GITLAB_TOKEN,
      base_url = "https://gitlab.com",
      telemetry = {
        enabled = false,
      },
      code_suggestions = {
        enabled = true,
        auto_filetypes = filetypes,
        ghost_text = {
          enabled = true,
          accept_suggestion = "<C-j>",
          stream = true,
        },
      },
    })
  end,
}
