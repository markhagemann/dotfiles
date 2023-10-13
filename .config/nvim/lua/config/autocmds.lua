-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "CursorHoldI", "FocusGained" }, {
--   command = "if mode() != 'c' | checktime | endif",
--   pattern = { "*" },
-- })

-- Disable autoformat for lua and json files
-- vim.api.nvim_create_autocmd({ "FileType" }, {
--   pattern = { "lua", "json" },
--   callback = function()
--     vim.b.autoformat = false
--   end,
-- })
