return {
  -- Database UI for managing database connections and queries
  "kristijanhusak/vim-dadbod-ui",
  enabled = false,
  dependencies = {
    { "tpope/vim-dadbod", lazy = true },
    { "kristijanhusak/vim-dadbod-completion", ft = { "psql", "plsql" }, lazy = true }, -- Optional
  },
  cmd = {
    "DBUI",
    "DBUIToggle",
    "DBUIAddConnection",
    "DBUIFindBuffer",
  },
  init = function()
    -- Your DBUI configuration
    vim.g.db_ui_use_nerd_fonts = 1
    vim.keymap.set("n", "<leader>od", ":DBUIToggle<cr>", { desc = "Open database" })
  end,
}
