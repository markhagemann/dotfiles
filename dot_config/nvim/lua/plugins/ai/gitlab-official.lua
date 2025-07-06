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
      statusline = {
        enabled = false, -- Disable GitLab's built-in statusline
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
