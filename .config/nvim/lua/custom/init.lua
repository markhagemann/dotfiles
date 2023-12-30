local opt = vim.opt
local g = vim.g

vim.cmd [[autocmd FileType * set formatoptions-=cro]] -- Stop continuation of comments on newline

vim.schedule(function()
  vim.keymap.del("n", '"')
end)

opt.autoread = true -- Enable auto read
opt.conceallevel = 0 -- Don't conceal anything
opt.foldcolumn = "1" -- '0' is not bad
opt.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
opt.foldlevelstart = 99
opt.foldenable = true
opt.swapfile = false

g.blamer_enabled = true
