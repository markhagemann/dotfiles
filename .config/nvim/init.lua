-- load plugins
require("pluginsList.lua")
require("web-devicons.lua")

require("utils.lua")
require("nvimTree.lua")
require("statusline.lua")
require("telescope-nvim.lua")
require("blamer-nvim.lua")

-- lsp
require("nvim-lspconfig.lua")
require("nvim-compe.lua")

require("gitsigns.lua")

require "colorizer".setup()

local cmd = vim.cmd
local g = vim.g
local indent = 2

cmd("colorscheme ayu")
cmd('let ayucolor="mirage"')
cmd "syntax enable"
cmd "syntax on"
vim.api.nvim_command('autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o')
vim.api.nvim_command('autocmd BufNewFile,BufRead * setlocal formatoptions-=cro')

g.auto_save = 1
g.indentLine_enabled = 1
g.indentLine_char_list = {'▏'}

g.mapleader = " "

require("treesitter.lua")
require("mappings.lua")

-- highlights
cmd("highlight Normal ctermbg=NONE guibg=NONE")
cmd("highlight NonText ctermbg=NONE guibg=NONE guifg=NONE ctermfg=NONE")
cmd("highlight VertSplit guibg=NONE guifg=#151b23")
cmd("highlight LineNr guibg=NONE")
cmd("highlight CursorLineNr guifg=#4dbcd6 guibg=NONE")
cmd("highlight SignColumn guibg=NONE")
cmd("highlight VertSplit guibg=NONE")
cmd("highlight DiffAdd guifg=#81A1C1 guibg = none")
cmd("highlight DiffChange guifg =#3A3E44 guibg = none")
cmd("highlight DiffModified guifg = #81A1C1 guibg = none")
cmd("highlight EndOfBuffer guifg=#282c34")

cmd("highlight TelescopeBorder   guifg=#3e4451")
cmd("highlight TelescopePromptBorder   guifg=#3e4451")
cmd("highlight TelescopeResultsBorder  guifg=#3e4451")
cmd("highlight TelescopePreviewBorder  guifg=#525865")
cmd("highlight PmenuSel  guibg=#98c379")

cmd("highlight FloatermBorder guifg=#3e4451")

-- tree folder name , icon color
cmd("highlight NvimTreeFolderIcon guifg = #61afef")
cmd("highlight NvimTreeFolderName guifg = #61afef")

require("nvim-autopairs").setup()

require("lspkind").init(
    {
        File = " "
    }
)
