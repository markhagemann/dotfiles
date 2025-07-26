-- set leader key to space
vim.g.mapleader = " "
-- set local leader key to space
vim.g.maplocalleader = ","

local keymap = vim.keymap -- for conciseness

---------------------
-- General Keymaps
---------------------

-- Use jk to exit insert mode
keymap.set("i", "jk", "<ESC>")
-- Use alt + ` to exit insert mode (habit from 60% keyboards)
keymap.set("i", "<M-`>", "<ESC>")

-- Clear search highlights
keymap.set("n", "<leader>nh", ":nohl<CR>")

-- Clear search and stop snippet on escape
keymap.set({ "i", "n", "s" }, "<esc>", function()
  vim.cmd("noh")
  -- LazyVim.cmp.actions.snippet_stop()
  return "<esc>"
end, { expr = true, desc = "Escape and clear hlsearch" })

-- Clear search, diff update and redraw
-- taken from runtime/lua/_editor.lua
keymap.set(
  "n",
  "<leader>ure",
  "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>",
  { desc = "Redraw / clear hlsearch / diff update" }
)

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
keymap.set("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "Next search result" })
keymap.set("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
keymap.set("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
keymap.set("n", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "Prev search result" })
keymap.set("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
keymap.set("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })

-- Completion
-- Remap Tab and Shift+Tab for LSP completion navigation
vim.api.nvim_set_keymap("i", "<Tab>", 'pumvisible() ? "\\<C-n>" : "\\<Tab>"', { expr = true, noremap = true })
vim.api.nvim_set_keymap("i", "<S-Tab>", 'pumvisible() ? "\\<C-p>" : "\\<S-Tab>"', { expr = true, noremap = true })

-- Save file
keymap.set({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })

-- Commenting
keymap.set("n", "gco", "o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add comment below" })
keymap.set("n", "gcO", "O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add comment above" })

-- Better up/down
keymap.set({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
keymap.set({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
keymap.set({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })
keymap.set({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })

-- Navigate buffers
keymap.set("n", "<S-l>", ":bnext<CR>", { silent = true })
keymap.set("n", "<S-h>", ":bprevious<CR>", { silent = true })

-- Resize window using <ctrl> arrow keys
keymap.set("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
keymap.set("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
keymap.set("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
keymap.set("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- Window management
keymap.set("n", "|", "<C-w>v", { desc = "Vertical split" }) -- split window vertically
keymap.set("n", "-", "<C-w>s", { desc = "Horizontal split" }) -- split window horizontally
keymap.set("n", "=", "<C-w>=", { desc = "Equalize splits" }) -- make split windows equal width & height
keymap.set("n", "<leader>wx", ":close<CR>", { desc = "Close split" }) -- close current split window

keymap.set("n", "<leader>to", ":tabnew<CR>", { desc = "Open new tab" })
keymap.set("n", "<leader>tx", ":tabclose<CR>", { desc = "Close current tab" })
keymap.set("n", "<leader>tn", ":tabn<CR>", { desc = "Go to next tab" })
keymap.set("n", "<leader>tp", ":tabp<CR>", { desc = "Go to previous tab" })

-- Replace word under cursor across entire buffer
keymap.set(
  "n",
  "<leader>rw",
  [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
  { desc = "Replace word under cursor" }
)

-- Save and load session
keymap.set("n", "<leader>SS", ":mksession! .session.vim<CR>", { noremap = true, silent = false })
keymap.set("n", "<leader>SL", ":source .session.vim<CR>", { noremap = true, silent = false })
