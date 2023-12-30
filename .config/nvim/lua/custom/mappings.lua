local M = {}

-- In order to disable a default keymap, use
M.disabled = {
  n = {
    ["<leader>h"] = "",
    ["<leader>v"] = "",
    ["<leader>x"] = "",
    -- ["<C-a>"] = "",
  },
}

-- Your custom mappings
M.abc = {
  n = {
    ["<C-p>"] = { ":Telescope find_files<CR>", "Telescope Files" },
    -- Delete single character without copying into register
    ["x"] = { '"_x' },
    ["<A-j>"] = { "<Esc>:m .+1<CR>==gi" },
    ["<A-k>"] = { "<Esc>:m .-2<CR>==gi" },
  },

  i = {
    ["jk"] = { "<ESC>", "escape insert mode", opts = { nowait = true } },
  },

  v = {
    ["p"] = { '"_dP' },
  },
}

return M
