local function map(mode, lhs, rhs, opts)
    local options = {noremap = true}
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

local silent_opts = {noremap = true, silent = true}
vim.g.mapleader = " "

--------------------------------------------------------------------
-- General
--------------------------------------------------------------------
-- Edit Vim config file in a new tab.
map("n", "<leader>ev", ":tabnew $MYVIMRC<CR>")

-- Remap macro record key
map("n", "Q", "q")
map("n", "q", "<Nop>")

-- This unsets the last search pattern register by hitting return
map("n", "<CR>", ":noh<CR><CR>")

-- Navigate around splits with a single key combo.
map("n", "<C-l>", "<C-w><C-l>")
map("n", "<C-h>", "<C-w><C-h>")
map("n", "<C-k>", "<C-w><C-k>")
map("n", "<C-j>", "<C-w><C-j>")

-- Use alt + hjkl to resize windows
map("n", "<M-j>", ":resize -2<CR>", silent_opts)
map("n", "<M-k>", ":resize +2<CR>", silent_opts)
map("n", "<M-h>", ":vertical resize -2<CR>", silent_opts)
map("n", "<M-l>", ":vertical resize +2<CR>", silent_opts)

-- Cycle through splits.
map("n", "<S-Tab>", "<C-w>w")

-- Split
map("n", "<leader>h", ":split<CR>", silent_opts)
map("n", "<leader>v", ":vsplit<CR>", silent_opts)

-- Switch buffers
map("n", "H", ":bp<CR>", silent_opts)
map("n", "L", ":bn<CR>", silent_opts)

-- Automatically 'gv' (go to previously selected visual block)
-- after indenting or unindenting.
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Press * to search for the term under the cursor or a visual selection and
-- then press a key below to replace all instances of it in the current file.
map("n", "<leader>r", ":%s///g<Left><Left><Left>", opts)
map("n", "<leader>rc", ":%s///gc<Left><Left><Left><Left>", opts)

-- The same as above but instead of acting on the whole file it will be
-- restricted to the previously visually selected range. You can do that by
-- pressing *, visually selecting the range you want it to apply to and then
-- press a key below to replace all instances of it in the current selection.
map("x", "<leader>r", ":%s///g<Left><Left><Left>", opts)
map("x", "<leader>rc", ":%s///gc<Left><Left><Left><Left>", opts)

--------------------------------------------------------------------
-- voldikss/vim-floaterm
--------------------------------------------------------------------
map("n", "<F1>", ":FloatermNew --height=0.85 --width=0.85 --wintype=floating --name=lazygit-float --title=lazygit --autoclose=2  lazygit<CR>", silent_opts)

--------------------------------------------------------------------
-- tpope/vim-commentary
--------------------------------------------------------------------
map("n", "<C-k>", ":Commentary<CR>", opts)
map("v", "<C-k>", ":Commentary<CR>", opts)

--------------------------------------------------------------------
-- LSP
--------------------------------------------------------------------
map("n", "<leader>ca", ":Lspsaga code_action<CR>", silent_opts)
map("v", "<leader>ca", ":<C-U>Lspsaga range_code_action<CR>", silent_opts)
map("n", "K", ":Lspsaga hover_doc<CR>", silent_opts)
map("n", "<C-f>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>", silent_opts)
map("n", "<C-b>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>", silent_opts)
map("n", "th", ":Lspsaga signature_help<CR>", silent_opts)
map("n", "<F2>", ":Lspsaga rename<CR>", silent_opts)
map("n", "td", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
-- map("n", "tD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
-- map("n", "td", "<cmd>lua require'lspsaga.provider'.preview_definition()<CR>", silent_opts)
map("n", "tr", "<cmd>lua require'lspsaga.provider'.lsp_finder()<CR>", silent_opts)
map("n", "ld", ":Lspsaga show_line_diagnostics<CR>", silent_opts)
map("n", "[e", ":Lspsaga diagnostic_jump_next<CR>", silent_opts)
map("n", "]e", ":Lspsaga diagnostic_jump_next<CR>", silent_opts)
-- map("n", "tr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
-- map("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
-- map("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
map("n", "ti", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
-- map("n", "th", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
map("n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
map("n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
map("n", "<space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
-- map("n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
-- map("n", "<space>e", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", opts)
-- map("n", "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
-- map("n", "]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
map("n", "<space>q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)
