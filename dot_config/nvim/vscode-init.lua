-- Minimal Neovim configuration for VSCode Neovim plugin
vim.o.number = true -- Show line numbers
vim.o.relativenumber = true -- Enable relative line numbers
vim.o.clipboard = "unnamedplus" -- Use system clipboard
vim.o.wrap = false -- Disable line wrapping
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.g.mapleader = " " -- space is the leader!
vim.g.maplocalleader = "\\"

-- Keymaps
require("config.keymaps")
