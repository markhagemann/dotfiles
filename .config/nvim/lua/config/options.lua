-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt
opt.conceallevel = 0 -- Don't conceal anything

return {
  opts = { style = "tokyonight-storm" },
}
