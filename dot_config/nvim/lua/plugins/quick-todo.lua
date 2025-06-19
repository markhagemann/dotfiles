return {
  "SyedAsimShah1/quick-todo.nvim",
  keys = {
    {
      "<leader>tt",
      "<cmd>lua require('quick-todo').open_todo()<CR>",
      mode = { "n" },
      silent = true,
      desc = "toggle todo",
    },
  },
  config = function()
    require("quick-todo").setup({
      window = {
        height = 0.5,
        width = 0.5,
        winblend = 0,
        border = "rounded",
      },
    })
  end,
}
