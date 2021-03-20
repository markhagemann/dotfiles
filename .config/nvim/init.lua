-- load plugins
require("blamer-nvim.lua")
require("lspkind").init(
    {
        File = " "
    }
)
require("lspsaga-nvim.lua")
require("mappings.lua")
require("nvim-autopairs").setup()
require("nvim-compe.lua")
require("nvim-lspconfig.lua")
require("nvimTree.lua")
require("pluginsList.lua")
require("statusline.lua")
require("telescope-nvim.lua")
require("treesitter.lua")
require("utils.lua")
require("vim-better-whitespace.lua")
require("vim-rooter.lua")
require("web-devicons.lua")
require "colorizer".setup()
require('nvim_comment').setup()

local cmd = vim.cmd
local g = vim.g

cmd("colorscheme ayu")
cmd('let ayucolor="mirage"')
cmd("let ayu_comment_italic=1")
cmd("let ayu_string_italic=0")
cmd("let ayu_type_italic=1")
cmd("let ayu_keyword_italic=1")
cmd("syntax enable")
cmd("syntax on")
vim.api.nvim_command('autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o')
vim.api.nvim_command('autocmd BufNewFile,BufRead * setlocal formatoptions-=cro')

g.vim_json_syntax_conceal = 0
g.indentLine_enabled = 1
g.indentLine_char_list = {'▏'}
g.indentLine_color_gui = '#2c394a'

g.dap_virtual_text = 'all frames'

g.mapleader = " "

-- highlights
cmd("highlight Normal ctermbg=NONE guibg=NONE")
cmd("highlight NonText ctermbg=NONE guibg=NONE guifg=NONE ctermfg=NONE")
cmd("highlight VertSplit guibg=NONE guifg=#151b23")
cmd("highlight LineNr guibg=NONE")
cmd("highlight CursorLineNr guifg=#5CCFE6 guibg=NONE")
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

-- lspsaga-nvim
 cmd("highlight Error guifg=#FF3333 guibg=NONE")

-- tree folder name , icon color
cmd("highlight NvimTreeFolderName guifg = #61afef")
cmd("highlight NvimTreeFolderIcon guifg = #73D0FF")
