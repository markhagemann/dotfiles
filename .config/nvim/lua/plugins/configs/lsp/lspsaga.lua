local status_ok, saga = pcall(require, "lspsaga")
if (not status_ok) then return end

saga.init_lsp_saga {
  server_filetype_map = {
    typescript = 'typescript'
  }
}

local opts = { noremap = true, silent = true }
vim.keymap.set('n', '[e', '<Cmd>Lspsaga diagnostic_jump_next<CR>', opts)
vim.keymap.set('n', ']e', '<Cmd>Lspsaga diagnostic_jump_prev<CR>', opts)
vim.keymap.set('n', 'K', '<Cmd>Lspsaga hover_doc<CR>', opts)
vim.keymap.set('n', 'gd', '<Cmd>Lspsaga lsp_finder<CR>', opts)
vim.keymap.set('i', '<C-k>', '<Cmd>Lspsaga signature_help<CR>', opts)
vim.keymap.set('n', 'gp', '<Cmd>Lspsaga preview_definition<CR>', opts)
vim.keymap.set('n', '<F2>', '<Cmd>Lspsaga rename<CR>', opts)
vim.keymap.set('n', '<leader>ca', '<Cmd>Lspsaga code_action<CR>', opts)
vim.keymap.set('v', '<leader>ca', '<Cmd><C-U>Lspsaga range_code_action<CR>', opts)
vim.keymap.set("n", "<leader>cd", "<cmd>Lspsaga show_line_diagnostics<CR>", opts)
vim.keymap.set("n", "<leader>cd", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opts)
