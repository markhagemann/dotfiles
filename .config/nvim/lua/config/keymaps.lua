-- set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

---------------------
-- General Keymaps
---------------------
-- Transparency Toggle
keymap.set("n", "TT", ":TransparentToggle<CR>", {noremap=true})

-- Use jk to exit insert mode
keymap.set("i", "jk", "<ESC>")

-- Clear search highlights
keymap.set("n", "<leader>nh", ":nohl<CR>")

-- Delete single character without copying into register
keymap.set("n", "x", '"_x')

-- Increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>") -- increment
keymap.set("n", "<leader>-", "<C-x>") -- decrement

-- Move text up and down
keymap.set("n", "<A-j>", "<Esc>:m .+1<CR>==gi")
keymap.set("n", "<A-k>", "<Esc>:m .-2<CR>==gi")

-- Visual --
-- Stay in indent mode
keymap.set("v", "<", "<gv")
keymap.set("v", ">", ">gv")

-- Move text up and down
keymap.set("v", "<A-j>", ":m .+1<CR>==")
keymap.set("v", "<A-k>", ":m .-2<CR>==")
keymap.set("v", "p", '"_dP')

-- Navigate buffers
keymap.set("n", "<S-l>", ":bnext<CR>")
keymap.set("n", "<S-h>", ":bprevious<CR>")

-- Resize with arrows
keymap.set("n", "<S-Up>", ":resize -2<CR>")
keymap.set("n", "<S-Down>", ":resize +2<CR>")
keymap.set("n", "<S-Left>", ":vertical resize -2<CR>")
keymap.set("n", "<S-Right>", ":vertical resize +2<CR>")

-- Window management
keymap.set("n", "<leader>-", "<C-w>v") -- split window vertically
keymap.set("n", "<leader>|", "<C-w>s") -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=") -- make split windows equal width & height
keymap.set("n", "<leader>sx", ":close<CR>") -- close current split window

keymap.set("n", "<leader>to", ":tabnew<CR>") -- open new tab
keymap.set("n", "<leader>tx", ":tabclose<CR>") -- close current tab
keymap.set("n", "<leader>tn", ":tabn<CR>") --  go to next tab
keymap.set("n", "<leader>tp", ":tabp<CR>") --  go to previous tab

----------------------
-- Plugin Keybinds
----------------------

-- comment
keymap.set("n", "<M-/>", "<cmd>lua require('Comment.api').toggle_current_linewise()<CR>")
keymap.set("x", "<M-/>", '<ESC><CMD>lua require("Comment.api").toggle_linewise_op(vim.fn.visualmode())<CR>')

-- DAP
keymap.set("n", "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<cr>")
keymap.set("n", "<leader>dc", "<cmd>lua require'dap'.continue()<cr>")
keymap.set("n", "<leader>di", "<cmd>lua require'dap'.step_into()<cr>")
keymap.set("n", "<leader>do", "<cmd>lua require'dap'.step_over()<cr>")
keymap.set("n", "<leader>dO", "<cmd>lua require'dap'.step_out()<cr>")
keymap.set("n", "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>")
keymap.set("n", "<leader>dl", "<cmd>lua require'dap'.run_last()<cr>")
keymap.set("n", "<leader>du", "<cmd>lua require'dapui'.toggle()<cr>")
keymap.set("n", "<leader>dt", "<cmd>lua require'dap'.terminate()<cr>")

-- Git
keymap.set("n", "<leader>gg", "<cmd>lua _LAZYGIT_TOGGLE()<CR>")

-- telescope
keymap.set(
  "n",
  "<C-p>",
  "<cmd>lua require'telescope.builtin'.find_files({ find_command = {'rg', '--files', '--hidden', '-g', '!.git' }})<cr>"
) -- find files within current working directory
keymap.set("n", "<leader>/", "<cmd>Telescope live_grep<cr>") -- find string in current working directory as you type
keymap.set("n", "<leader>.", "<cmd>Telescope grep_string<cr>") -- find string under cursor in current working directory
keymap.set("n", "<leader>,", "<cmd>Telescope buffers<cr>") -- list open buffers in current neovim instance
keymap.set("n", "<leader>ht", "<cmd>Telescope help_tags<cr>") -- list available help tags

keymap.set("n", "<leader>gc", "<cmd>Telescope git_commits<cr>") -- list all git commits (use <cr> to checkout) ["gc" for git commits]
keymap.set("n", "<leader>gfc", "<cmd>Telescope git_bcommits<cr>") -- list git commits for current file/buffer (use <cr> to checkout) ["gfc" for git file commits]
keymap.set("n", "<leader>gb", "<cmd>Telescope git_branches<cr>") -- list git branches (use <cr> to checkout) ["gb" for git branch]
keymap.set("n", "<leader>gs", "<cmd>Telescope git_status<cr>") -- list current changes per file with diff preview ["gs" for git status]

keymap.set("n", "<leader>rs", ":LspRestart<CR>") -- mapping to restart lsp if necessary

-- trouble
keymap.set("n", "<leader>xx", "<cmd>TroubleToggle<cr>", { silent = true, noremap = true })
keymap.set("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", { silent = true, noremap = true })
keymap.set("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>", { silent = true, noremap = true })
keymap.set("n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>", { silent = true, noremap = true })
keymap.set("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", { silent = true, noremap = true })
keymap.set("n", "gR", "<cmd>TroubleToggle lsp_references<cr>", { silent = true, noremap = true })
