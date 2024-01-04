return {
  {
    "numToStr/FTerm.nvim",
    event = "VeryLazy",
    config = function()
      local fterm = require("FTerm")
      vim.api.nvim_set_keymap("n", "<leader>tt", ":lua require('FTerm').toggle()<CR>", { noremap = true })
      vim.api.nvim_set_keymap("t", "<leader>tt", '<C-\\><C-n>:lua require("FTerm").toggle()<CR>', { noremap = true })

      fterm.setup({
        blend = 5,
        dimensions = {
          height = 0.95,
          width = 0.95,
          x = 0.5,
          y = 0.5,
        },
      })

      local lazygit = fterm:new({
        ft = "fterm_lazygit", -- You can also override the default filetype, if you want
        cmd = "lazygit",
      })

      -- Use this to toggle gitui in a floating terminal
      vim.keymap.set("n", "<leader>lg", function()
        lazygit:toggle()
      end)
    end,
  },
}
