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
end, { expr = true, desc = "escape and clear hlsearch" })

-- Clear search, diff update and redraw
-- taken from runtime/lua/_editor.lua
keymap.set(
  "n",
  "<leader>ure",
  "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>",
  { desc = "redraw / clear hlsearch / diff Update" }
)

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
keymap.set("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "next search result" })
keymap.set("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "next search result" })
keymap.set("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "next search result" })
keymap.set("n", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "prev search result" })
keymap.set("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "prev search result" })
keymap.set("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "prev search result" })

-- Add undo break-points
keymap.set("i", ",", ",<c-g>u")
keymap.set("i", ".", ".<c-g>u")
keymap.set("i", ";", ";<c-g>u")

-- Save file
keymap.set({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "save file" })

-- Commenting
keymap.set("n", "gco", "o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "add comment below" })
keymap.set("n", "gcO", "O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "add comment above" })

-- Move Lines
keymap.set("n", "<A-j>", "<cmd>execute 'move .+' . v:count1<cr>==", { desc = "move down" })
keymap.set("n", "<A-k>", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = "move up" })
keymap.set("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "move Down" })
keymap.set("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "move Up" })
keymap.set("v", "<A-j>", ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", { desc = "move down" })
keymap.set("v", "<A-k>", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = "move up" })

-- Visual --
-- Stay in indent mode
keymap.set("v", "<", "<gv")
keymap.set("v", ">", ">gv")

-- Move text up and down
keymap.set("v", "<A-j>", ":m .+1<CR>==")
keymap.set("v", "<A-k>", ":m .-2<CR>==")

-- System clipboard
keymap.set({ "n", "x" }, "<leader>y", '"+y', { desc = "copy to system clipboard" })
keymap.set({ "n", "x" }, "<leader>Y", '"+yg_', { desc = "copy to system clipboard" })
keymap.set({ "n", "x" }, "<leader>p", '"+p', { desc = "paste from system clipboard" })
keymap.set({ "n", "x" }, "<leader>P", '"+P', { desc = "paste from system clipboard" })

-- Better up/down
keymap.set({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
keymap.set({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
keymap.set({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })
keymap.set({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })

-- Navigate buffers
keymap.set("n", "<S-l>", ":bnext<CR>", { silent = true })
keymap.set("n", "<S-h>", ":bprevious<CR>", { silent = true })

-- Resize window using <ctrl> arrow keys
keymap.set("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "increase window height" })
keymap.set("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "decrease window height" })
keymap.set("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "decrease window width" })
keymap.set("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "increase window width" })

-- Window management
keymap.set("n", "|", "<C-w>v", { desc = "vertical split" }) -- split window vertically
keymap.set("n", "-", "<C-w>s", { desc = "horizontal split" }) -- split window horizontally
keymap.set("n", "=", "<C-w>=", { desc = "equalize splits" }) -- make split windows equal width & height
keymap.set("n", "<leader>wx", ":close<CR>", { desc = "close split" }) -- close current split window

keymap.set("n", "<leader>to", ":tabnew<CR>", { desc = "open new tab" })
keymap.set("n", "<leader>tx", ":tabclose<CR>", { desc = "close current tab" })
keymap.set("n", "<leader>tn", ":tabn<CR>", { desc = "go to next tab" })
keymap.set("n", "<leader>tp", ":tabp<CR>", { desc = "go to previous tab" })

-- Replace word under cursor across entire buffer
keymap.set(
  "n",
  "<leader>rw",
  [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
  { desc = "replace word under cursor" }
)

-- Save and load session
keymap.set("n", "<leader>SS", ":mksession! .session.vim<CR>", { noremap = true, silent = false })
keymap.set("n", "<leader>SL", ":source .session.vim<CR>", { noremap = true, silent = false })
