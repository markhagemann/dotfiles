-- Global variables
Homedir = os.getenv("HOME")
Sessiondir = vim.fn.stdpath("data") .. "/sessions"

-- Each entry can be:
-- * the name of a detector function like `lsp` or `cwd`
-- * a pattern or array of patterns like `.git` or `lua`.
-- * a function with signature `function(buf) -> string|string[]`
vim.g.root_spec = { "lsp", { ".git", "lua" }, "cwd" }

-- Set filetype to `bigfile` for files larger than 1.5 MB
-- Only vim syntax will be enabled (with the correct filetype)
-- LSP, treesitter and other ft plugins will be disabled.
-- mini.animate will also be disabled.
vim.g.bigfile_size = 1024 * 1024 * 1.5 -- 1.5 MB

-- Global options
vim.g.mapleader = " " -- space is the leader!
vim.g.maplocalleader = "\\"
vim.g.loaded_perl_provider = 0 -- Do not load Perl

local opt = vim.opt

-- Buffer options
opt.autoindent = true
opt.expandtab = true -- Use spaces instead of tabs
opt.shiftwidth = 2 -- Size of an indent
opt.smartindent = true -- Insert indents automatically
opt.softtabstop = 2 -- Number of spaces tabs count for
opt.tabstop = 2 -- Number of spaces in a tab

-- Vim options
opt.autowrite = true -- Enable auto write
-- only set clipboard if not in ssh, to make sure the OSC 52
-- integration works automatically. Requires Neovim >= 0.10.0
opt.clipboard = vim.env.SSH_TTY and "" or "unnamedplus" -- Sync with system clipboard
opt.completeopt = "menu,menuone,noselect"
opt.conceallevel = 0 -- Don't conceal anything
opt.confirm = true -- Confirm to save changes before exiting modified buffer
opt.cursorline = true -- Enable highlighting of the current line
opt.emoji = false -- Disable emoji support
opt.fillchars = { -- Fill characters for various elements
  foldopen = "",
  foldclose = "",
  fold = " ",
  foldsep = " ",
  diff = "╱",
  eob = " ",
}
opt.foldenable = true -- Enable folding
opt.foldcolumn = "1" -- Fold column width
opt.foldlevel = 99 -- Using ufo.nvim, so set a high default fold level
opt.foldlevelstart = 99 -- Show all folds when opening a file
opt.formatoptions = "jcroqlnt" -- tcqj
opt.grepformat = "%f:%l:%c:%m" -- Format for grep results
opt.grepprg = "rg --vimgrep" -- Use ripgrep for grep
opt.ignorecase = true -- Ignore case
opt.inccommand = "nosplit" -- preview incremental substitute
opt.jumpoptions = "view" -- Keep cursor position when jumping
opt.laststatus = 3 -- global statusline
opt.linebreak = true -- Wrap lines at convenient points
opt.list = true -- Show some invisible characters (tabs...
opt.mouse = "a" -- Enable mouse mode
opt.number = true -- Print line number
opt.numberwidth = 2 -- Set number column width
opt.pumblend = 0 -- Popup blend
opt.pumheight = 10 -- Maximum number of entries in a popup
opt.relativenumber = true -- Relative line numbers
opt.scrolloff = 4 -- Lines of context
opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }
opt.shiftround = true -- Round indent
opt.shortmess = {
  A = true, -- ignore annoying swap file messages
  c = true, -- Do not show completion messages in command line
  F = true, -- Do not show file info when editing a file, in the command line
  I = true, -- Do not show the intro message
  W = true, -- Do not show "written" in command line when writing
}
opt.showmode = false -- Dont show mode since we have a statusline
opt.showmatch = true -- Show matching brackets by flickering
opt.sidescrolloff = 8 -- Columns of context
opt.signcolumn = "yes" -- Always show the signcolumn, otherwise it would shift the text each time
opt.smartcase = true -- Don't ignore case with capitals
opt.smoothscroll = true -- Smooth scrolling
opt.spelllang = { "en" } -- Set spell checking language
opt.spelloptions:append("noplainbuffer")
opt.splitbelow = true -- Put new windows below current
opt.splitkeep = "screen" -- Keep the screen position when splitting
opt.splitright = true -- Put new windows right of current
opt.termguicolors = true -- True color support
opt.timeoutlen = vim.g.vscode and 1000 or 300 -- Lower than default (1000) to quickly trigger mini.clue
opt.undofile = true -- Enable persistent undo
opt.undolevels = 10000 -- Number of undos to remember
opt.updatetime = 200 -- Save swap file and trigger CursorHold
opt.virtualedit = "block" -- Allow cursor to move where there is no text in visual block mode
opt.wildmode = "longest:full,full" -- Command-line completion mode
opt.winminwidth = 5 -- Minimum window width
opt.wrap = false -- Disable line wrap

-- Fix markdown indentation settings
vim.g.markdown_recommended_style = 0

-- Create folders for our backups, undos, swaps and sessions if they don't exist
vim.schedule(function()
  vim.cmd("silent call mkdir(stdpath('data').'/backups', 'p', '0700')")
  vim.cmd("silent call mkdir(stdpath('data').'/undos', 'p', '0700')")
  vim.cmd("silent call mkdir(stdpath('data').'/swaps', 'p', '0700')")
  vim.cmd("silent call mkdir(stdpath('data').'/sessions', 'p', '0700')")

  opt.backupdir = vim.fn.stdpath("data") .. "/backups" -- Use backup files
  opt.directory = vim.fn.stdpath("data") .. "/swaps" -- Use Swap files
  opt.undodir = vim.fn.stdpath("data") .. "/undos" -- Set the undo directory
end)
