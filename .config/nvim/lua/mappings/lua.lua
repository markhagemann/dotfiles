local function map(mode, lhs, rhs, opts)
    local options = {noremap = true}
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

local silent_opts = {noremap = true, silent = true}

-- Edit Vim config file in a new tab.
map("n", "<leader>ev", ":tabnew $MYVIMRC<CR>")

-- Remap macro record key
-- nnoremap Q q
-- nnoremap q <Nop>

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

