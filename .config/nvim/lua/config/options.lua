local opt = vim.opt -- for conciseness

opt.showmode = false -- Already in the status line

-- Decrease update time
opt.updatetime = 250
opt.timeoutlen = 300

-- Undo settings
opt.undofile = true -- Save undos after file closes
opt.undolevels = 1000 -- How many undos
opt.undoreload = 10000 -- number of lines to save for undo

-- line numbers
opt.relativenumber = true -- show relative line numbers
opt.number = true -- shows absolute line number on cursor line (when relative number is on)
opt.scrolloff = 10 -- Minimal number of screen lines to keep above and below the cursor.

-- tabs & indentation
opt.tabstop = 2 -- 2 spaces for tabs (prettier default)
opt.shiftwidth = 2 -- 2 spaces for indent width
opt.expandtab = true -- expand tab to spaces
opt.autoindent = true -- copy indent from current line when starting new one

-- popups
opt.pumblend = 0 -- Popup blend
opt.pumheight = 10 -- Maximum number of entries in a popup

-- line wrapping
opt.wrap = false -- disable line wrapping

-- search settings
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true -- if you include mixed case in your search, assumes you want case-sensitive

-- cursor line
opt.cursorline = true -- highlight the current cursor line

-- appearance

-- turn on termguicolors for nightfly colorscheme to work
-- (have to use iterm2 or any other true color terminal)
opt.termguicolors = true
opt.background = "dark" -- colorschemes that can be light or dark will be made dark
opt.signcolumn = "yes" -- show sign column so that text doesn't shift

-- backspace
opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position

-- clipboard
opt.clipboard:append("unnamedplus") -- use system clipboard as default register

-- split windows
opt.splitright = true -- split vertical window to the right
opt.splitbelow = true -- split horizontal window to the bottom

opt.iskeyword:append("-") -- consider string-string as whole word

-- folding
opt.foldenable = true
opt.foldcolumn = "auto" -- show foldcolumn in nvim 0.9
opt.foldnestmax = 0
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.fillchars = {
  fold = " ",
  foldopen = "",
  foldsep = " ",
  foldclose = "",
  stl = " ",
  eob = " ",
}
opt.foldmethod = "expr"
-- opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldexpr = ""

opt.cursorline = true
opt.mousemoveevent = true

vim.g.blamer_enabled = true
vim.g.nuuid_no_mappings = 1
