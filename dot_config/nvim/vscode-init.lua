-- Minimal Neovim configuration for VSCode Neovim plugin
vim.o.number = true -- Show line numbers
vim.o.relativenumber = true -- Enable relative line numbers
vim.o.clipboard = "unnamedplus" -- Use system clipboard
vim.o.wrap = false -- Disable line wrapping

-- Keymaps
vim.api.nvim_set_keymap("i", "jk", "<Esc>", { noremap = true, silent = true })
