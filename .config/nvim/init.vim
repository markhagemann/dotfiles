if &compatible
  call dein#add('voldikss/vim-floaterm')
  set nocompatible
endif
" ------------------------------------------------------------------
" Plugins {{{
" ------------------------------------------------------------------
" Add the dein installation directory into runtimepath
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

" Define plugins for dein to install
if dein#load_state('~/.cache/dein')
  call dein#begin('~/.cache/dein')
  call dein#add('~/.cache/dein/repos/github.com/Shougo/dein.vim')

  " Autocompletion
  call dein#add('jiangmiao/auto-pairs')
  call dein#add('alvan/vim-closetag')
  " Colorscheme
  call dein#add('ayu-theme/ayu-vim')
  call dein#add('TaDaa/vimade')
  " Colorizer
  call dein#add('norcalli/nvim-colorizer.lua')
  call dein#add('junegunn/rainbow_parentheses.vim')
  " Comment out blocks of code
  call dein#add('tpope/vim-commentary')
  " File manager
  call dein#add('shougo/defx.nvim')
  call dein#add('yazdani42/nvim-web-devicons')
  call dein#add('kristijanhusak/defx-icons')
  call dein#add('kristijanhusak/defx-git')
  call dein#add('airblade/vim-rooter')
  " call dein#add('ryanoasis/vim-devicons')
  " File searching and replacing
  call dein#add('brooth/far.vim')
  " Floating Terminal / Window Management
  call dein#add('voldikss/vim-floaterm')
  call dein#add('chrisbra/NrrwRgn')
  " Git
  call dein#add('airblade/vim-gitgutter')
  call dein#add('tpope/vim-fugitive')
  call dein#add('APZelos/blamer.nvim')
  " IndentLine
  call dein#add('Yggdroot/indentLine')
  call dein#add('lukas-reineke/indent-blankline.nvim')
  " Language support
  call dein#add('neovim/nvim-lspconfig')
  " call dein#add('glepnir/lspsaga.nvim')
  call dein#add('RishabhRD/popfix')
  call dein#add('RishabhRD/nvim-lsputils')
  call dein#add('hrsh7th/nvim-compe')
  call dein#add('kosayoda/nvim-lightbulb')
  call dein#add('tjdevries/nlua.nvim')
  call dein#add('tjdevries/lsp_extensions.nvim')
  call dein#add('lukas-reineke/format.nvim')
  call dein#add('elzr/vim-json')
  call dein#add('leafgarland/typescript-vim')
  call dein#add('peitalin/vim-jsx-typescript')
  call dein#add('posva/vim-vue')
  call dein#add('tpope/vim-sleuth')
  call dein#add('mustache/vim-mustache-handlebars')
  " Scratchpad
  call dein#add('Konfekt/vim-scratchpad')
  " Status bar
  call dein#add('itchyny/lightline.vim')
  call dein#add('sinetoami/lightline-hunks')
  call dein#add('halkn/lightline-lsp')
  "Telescope
  call dein#add('nvim-lua/popup.nvim')
  call dein#add('nvim-lua/plenary.nvim')
  call dein#add('nvim-telescope/telescope.nvim')
  " Text navigation / manipulation
  call dein#add('unblevable/quick-scope')
  call dein#add('chaoren/vim-wordmotion')
  " Treesitter
  call dein#add('nvim-treesitter/nvim-treesitter', { 'merged': 0 })
  call dein#add('nvim-treesitter/playground')
  " Whitespace removal
  call dein#add('ntpeters/vim-better-whitespace')

  if !has('nvim')
    call dein#add('roxma/nvim-yarp')
    call dein#add('roxma/vim-hug-neovim-rpc')
  endif

  if has("nvim")
    set inccommand=nosplit
  endif

  call dein#end()
  call dein#save_state()
endif
" }}}
" ------------------------------------------------------------------
" General {{{
" ------------------------------------------------------------------
filetype plugin on
let g:mapleader=" "
syntax enable                           " Enables syntax highlighing
set shell=zsh                           " Set shell to zsh
set iskeyword+=-                        " treat dash separated words as a word text object
set formatoptions-=cro                  " Stop newline continution of comments
set hidden                              " Required to keep multiple buffers open multiple buffers
set nowrap                              " Display long lines as just one line
set encoding=utf-8                      " The encoding displayed
set pumheight=20                        " Makes popup menu smaller
set fileencoding=utf-8                  " The encoding written to file
set ruler                               " Show the cursor position all the time
set lazyredraw                          " When this option is set, the screen will not be redrawn while executing macros
set cmdheight=1                         " More space for displaying messages
set noshowcmd                           " Don't show entered command
set noshowmode                          " Don't show mode - handled by lightline
set mouse=a                             " Enable your mouse
set splitbelow                          " Horizontal splits will automatically be below
set splitright                          " Vertical splits will automatically be to the right
set t_Co=256                            " Support 256 colors
set smarttab                            " Makes tabbing smarter will realize you have 2 vs 4
set expandtab                           " Converts tabs to spaces
set smartindent                         " Makes indenting smart
set autoindent                          " Good auto indent
set laststatus=2                        " Always display the status line
set scrolloff=6                         " Keep 6 lines above/below cursor
set number                              " Line numbers
set rnu                                 " Relative line numbers
set cursorline                          " Enable highlighting of the current line
set background=dark                     " tell vim what the background color looks like
set nobackup                            " This is recommended by coc
set nowritebackup                       " This is recommended by coc
set shortmess+=c                        " Don't pass messages to |ins-completion-menu|.
set signcolumn=yes                      " Always show the signcolumn, otherwise it would shift the text each time
set updatetime=0                      " Faster completion
set timeoutlen=500                      " By default timeoutlen is 1000 ms
set clipboard=unnamedplus               " Copy paste between vim and everything else
set ignorecase smartcase                " ignore case only when the pattern contains no capital letters
set incsearch
set noswapfile
set undolevels=10000

autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
autocmd BufNewFile,BufRead * setlocal formatoptions-=cro
" Enable spellcheck for markdown files
autocmd BufRead,BufNewFile *.md setlocal spell
" Try fix syntax highlighting issues on large files
autocmd BufEnter *.{js,ts,jsx,tsx} :syntax sync fromstart
" autocmd BufEnter,BufWinEnter,TabEnter *.rs :lua require'lsp_extensions'.inlay_hints{}

" You can't stop me
cmap w!! w !sudo tee %

" Edit Vim config file in a new tab.
map <leader>ev :tabnew $MYVIMRC<CR>

"This unsets the last search pattern register by hitting return
nnoremap <CR> :noh<CR><CR>

" Navigate around splits with a single key combo.
nnoremap <C-l> <C-w><C-l>
nnoremap <C-h> <C-w><C-h>
nnoremap <C-k> <C-w><C-k>
nnoremap <C-j> <C-w><C-j>
 " Use alt + hjkl to resize windows
nnoremap <silent> <M-j>    :resize -2<CR>
nnoremap <silent> <M-k>    :resize +2<CR>
nnoremap <silent> <M-h>    :vertical resize -2<CR>
nnoremap <silent> <M-l>    :vertical resize +2<CR>

" Cycle through splits.
nnoremap <S-Tab> <C-w>w

" Quicker escape binding
inoremap jk <Esc>
inoremap kj <Esc>

" Split
noremap <silent><leader>h :split<cr>
noremap <silent><leader>v :vsplit<cr>

" Switch buffers
nnoremap <silent>H :silent bp<CR>
nnoremap <silent>L :silent bn<CR>

" Automatically 'gv' (go to previously selected visual block)
" after indenting or unindenting.
vnoremap < <gv
vnoremap > >gv

" Set colorscheme and related settings
syntax enable
" checks if your terminal has 24-bit color support
if (has("nvim"))
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif
if (has("termguicolors"))
  set termguicolors
  hi LineNr ctermbg=NONE guibg=NONE
endif
set numberwidth=2
let ayucolor="mirage" " for mirage version of theme
colorscheme ayu
" colorscheme candid
" let g:candid_color_store = {
"     \ "black": {"gui": "#121212", "cterm256": "0"},
"     \ "white": {"gui": "#f4f4f4", "cterm256": "255"},
"     \}
" hi! Normal ctermbg=NONE guibg=NONE
" hi! NonText ctermbg=NONE guibg=NONE guifg=NONE ctermfg=NONE
hi VertSplit guibg=NONE guifg=#151b23
" hi VertSplit guibg=cyan guifg=cyan
set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
\,a:blinkwait400-blinkoff800-blinkon100-Cursor/lCursor
\,sm:block-blinkwait175-blinkoff150-blinkon175

"}}}
" ------------------------------------------------------------------
" TaDaa/vimade {{{
" ------------------------------------------------------------------
let g:vimade = {
            \'fadelevel': 0.3,
            \'checkinterval': 100,
            \'enablefocusfading': 1
            \}
autocmd BufNew * ++once if !exists('g:vimade_loaded') |
            \execute 'VimadeEnable' | endif
autocmd FocusLost * ++once if !exists('g:vimade_loaded') |
            \execute 'VimadeEnable' |
            \call vimade#FocusLost() | endif
"}}}
" ------------------------------------------------------------------
" Folding {{{
" ------------------------------------------------------------------
set nofoldenable
set foldmethod=indent
set foldcolumn=2
hi foldcolumn guibg=bg
hi Folded guifg=#8294ad guibg=bg
hi FoldColumn guifg=#233144
hi clear SignColumn
autocmd FileType vim setlocal foldmethod=marker
" Sourced from https://www.vimfromscratch.com/articles/vim-folding/
autocmd FileType javascript setlocal foldmethod=expr
autocmd FileType javascript setlocal foldexpr=JSFolds()
function! JSFolds()
  let thisline = getline(v:lnum)
  if thisline =~? '\v^\s*$'
    return '-1'
  endif

  if thisline =~ '^import.*$'
    return 1
  else
    return indent(v:lnum) / &shiftwidth
  endif
endfunction

" }}}
" ------------------------------------------------------------------
" Defx / File manager settings {{{
" ------------------------------------------------------------------
nnoremap <silent>- :Defx -show-ignored-files<CR>
nnoremap <silent>= :Defx `expand('%:p:h')` -show-ignored-files -search=`expand('%:p')`<CR>
call defx#custom#option('_', {
  \ 'winwidth': 30,
  \ 'split': 'vertical',
  \ 'direction': 'topleft',
  \ 'show_ignored_files': 0,
  \ 'buffer_name': 'defxplorer',
  \ 'toggle': 1,
  \ 'columns': 'icon:indent:icons:filename',
  \ 'resume': 1,
  \ })
call defx#custom#column('git', 'show_ignored', 1)
let g:defx_git#indicators = {
  \ 'Modified'  : '!',
  \ 'Staged'    : '✚',
  \ 'Untracked' : '?',
  \ 'Renamed'   : '»',
  \ 'Unmerged'  : '≠',
  \ 'Ignored'   : 'ⁱ',
  \ 'Deleted'   : '✖',
  \ 'Unknown'   : '*'
  \ }
call defx#custom#column('icon', {
  \ 'directory_icon': '▸',
  \ 'opened_icon': '▾',
  \ })
augroup defx_colors
  autocmd!
  autocmd ColorScheme * highlight DefxIconsOpenedTreeIcon guifg=#FFCB6B
  autocmd ColorScheme * highlight DefxIconsNestedTreeIcon guifg=#FFCB6B
  autocmd ColorScheme * highlight DefxIconsClosedTreeIcon guifg=#FFCB6B
augroup END
augroup defx-extensions
  autocmd!
  " Close defx if it's the only buffer left in the window
  " autocmd WinEnter * if &ft == 'defx' && winnr('$') == 1 | q | endif
  " Move focus to the next window if current buffer is defx
  autocmd BufWritePost * call defx#redraw() " Redraw on file change
  autocmd TabLeave * if &ft == 'defx' | wincmd w | endif
  autocmd FileType defx do WinEnter | call s:defx_my_settings()
augroup END

autocmd FileType defx call s:defx_my_settings()
function! s:defx_my_settings() abort
  setlocal conceallevel=3
  setlocal concealcursor=inc
  " Define mappings
  nnoremap <silent><buffer><expr> <esc>
  \ defx#do_action('quit')
  nnoremap <silent><buffer><expr> <CR>
  \ defx#do_action('multi', ['drop', 'quit'])
  nnoremap <silent><buffer><expr> c
  \ defx#do_action('copy')
  nnoremap <silent><buffer><expr> m
  \ defx#do_action('move')
  nnoremap <silent><buffer><expr> p
  \ defx#do_action('paste')
  nnoremap <silent><buffer><expr> V
  \ defx#do_action('drop', 'vsplit')
  nnoremap <silent><buffer><expr> o
  \ defx#do_action('open_or_close_tree')
  nnoremap <silent><buffer><expr> K
  \ defx#do_action('new_directory')
  nnoremap <silent><buffer><expr> N
  \ defx#do_action('new_file')
  nnoremap <silent><buffer><expr> M
  \ defx#do_action('new_multiple_files')
  nnoremap <silent><buffer><expr> d
  \ defx#do_action('remove')
  nnoremap <silent><buffer><expr> r
  \ defx#do_action('rename')
  nnoremap <silent><buffer><expr> !
  \ defx#do_action('execute_command')
  nnoremap <silent><buffer><expr> x
  \ defx#do_action('execute_system')
  nnoremap <silent><buffer><expr> yy
  \ defx#do_action('yank_path')
  nnoremap <silent><buffer><expr> .
  \ defx#do_action('toggle_ignored_files')
  nnoremap <silent><buffer><expr> ;
  \ defx#do_action('repeat')
  nnoremap <silent><buffer><expr> ~
  \ defx#do_action('cd')
  nnoremap <silent><buffer><expr> q
  \ defx#do_action('quit')
  nnoremap <silent><buffer><expr> <Space>
  \ defx#do_action('toggle_select') . 'j'
  nnoremap <silent><buffer><expr> *
  \ defx#do_action('toggle_select_all')
  " Allow vim movement keys for navigation
  nnoremap <silent><buffer><expr> h
  \ defx#do_action('cd', ['..'])
  nnoremap <silent><buffer><expr> H
  \ defx#do_action('cd', ['..'])
  nnoremap <silent><buffer><expr> j
  \ line('.') == line('$') ? 'gg' : 'j'
  nnoremap <silent><buffer><expr> k
  \ line('.') == 1 ? 'G' : 'k'
  nnoremap <silent><buffer><expr> l defx#do_action('drop')
  nnoremap <silent><buffer><expr> L defx#do_action('drop')
  nnoremap <silent><buffer><expr> <C-r>
  \ defx#do_action('redraw')
  nnoremap <silent><buffer><expr> <C-g>
  \ defx#do_action('print')
  nnoremap <silent><buffer><expr> cd
  \ defx#do_action('change_vim_cwd')
endfunction
" }}}
" ------------------------------------------------------------------
" itchyny/lightline {{{
" ------------------------------------------------------------------
let g:lightline = {
  \ 'component_function': {
  \   'filename': 'LightlineFilename',
  \ },
  \ 'component_expand': {
  \   'lsp_warnings': 'lightline_lsp#warnings',
  \   'lsp_errors':   'lightline_lsp#errors',
  \   'lsp_ok':       'lightline_lsp#ok',
  \ },
  \ 'component_type': {
  \   'lsp_warnings': 'warning',
  \   'lsp_errors':   'error',
  \   'lsp_ok':       'middle',
  \ },
  \ 'colorscheme': 'ayu',
  \   'active': {
  \     'left': [[ 'mode', 'paste'], ['lightline_hunks' ], ['readonly', 'filename']],
  \     'right': [[ 'lsp_errors', 'lsp_warnings', 'lsp_ok', 'lineinfo' ], [ 'percent' ], ['fileencoding', 'filetype']]
  \   }
  \ }

let g:lightline.component_function = {
  \  'lightline_hunks': 'lightline#hunks#composer',
  \ }

function! LightlineFilename()
  let root = fnamemodify(get(b:, 'git_dir'), ':h')
  let path = expand('%:p')
  if path[:len(root)-1] ==# root
    return path[len(root)+1:]
  endif
  return expand('%')
endfunction
" ------------------------------------------------------------------
" ntpeters/vim-better-whitespace {{{
" ------------------------------------------------------------------
let g:strip_whitespace_confirm=0
let g:strip_whitespace_on_save=1
" }}}
" ------------------------------------------------------------------
" alvan/vim-closetag {{{
" ------------------------------------------------------------------
let g:closetag_filenames = '*.html,*.xhtml,*.phtml'
let g:closetag_xhtml_filenames = '*.xhtml,*.jsx,*.js,*.tsx,*.ts'
let g:closetag_filetypes = 'html,xhtml,phtml,javascript'
let g:closetag_emptyTags_caseSensitive = 1
" }}}
" ------------------------------------------------------------------
" Indent settings {{{
" ------------------------------------------------------------------

" Show whitespace as characters
set list!
set listchars=eol:↴
set listchars+=tab:│⋅
set listchars+=trail:~
set listchars+=extends:❯
set listchars+=precedes:❮
set listchars+=nbsp:_
set listchars+=space:⋅

let g:indent_blankline_space_char = ' '
let g:indent_blankline_debug = v:true
let g:indentLine_char_list = ['▏']
let g:indentLine_color_gui = '#453c47'
let g:indentLine_setConceal = 0
let g:indentLine_leadingSpaceEnabled = 1
let g:indentLine_leadingSpaceChar = ' '
let g:indentLine_fileTypeExclude = ['help', 'defx', 'vimwiki', 'prcomment', 'md', 'json']
" Json
let g:vim_json_syntax_conceal = 0
let g:vim_json_conceal = 0

" function SetZeroConcealLevel()
"     setlocal conceallevel=0
" endfunction
" autocmd BufNewFile,Bufread *.md, *.json call SetZeroConcealLevel()
" ------------------------------------------------------------------
" APZelos/blamer.nvim {{{
" ------------------------------------------------------------------
let g:blamer_enabled = 1
let g:blamer_delay = 500
let g:blamer_show_in_visual_modes = 0
" }}}
" ------------------------------------------------------------------
" airblade/vim-rooter {{{
" ------------------------------------------------------------------
let g:rooter_silent_chdir = 1
" }}}
" ------------------------------------------------------------------
" tpope/vim-commentary {{{
" ------------------------------------------------------------------
nnoremap <space>/ :Commentary<CR>
vnoremap <space>/ :Commentary<CR>
" }}}
" ------------------------------------------------------------------
" junegunn/rainbow_parentheses.vim {{{
" ------------------------------------------------------------------
let g:rainbow#max_level = 16
let g:rainbow#pairs = [['(', ')'], ['[', ']'], ['{', '}']]

autocmd FileType * RainbowParentheses
" }}}
" ------------------------------------------------------------------
" voldikss/vim-floaterm {{{
" ------------------------------------------------------------------
hi FloatermBorder guifg=cyan
nnoremap <silent> <F1> :FloatermNew --height=0.85 --width=0.85 --wintype=floating --name=lazygit-float --title=lazygit --autoclose=2  lazygit<CR>
" }}}
" ------------------------------------------------------------------
" brooth/far.vim {{{
" ------------------------------------------------------------------
let g:far#source = 'agnvim'
" }}}
" ------------------------------------------------------------------
" unblevable/quick-scope
" ------------------------------------------------------------------
" Trigger a highlight in the appropriate direction when pressing these keys:
" let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
let g:qs_ignorecase = 1
" }}}
" ------------------------------------------------------------------
" Search & Replace General {{{
" https://bluz71.github.io/2019/03/11/find-replace-helpers-for-vim.html
" ------------------------------------------------------------------
let g:grepper = {}
let g:grepper.tools = ["rg"]

nnoremap <Leader>S
  \ :let @s='\<'.expand('<cword>').'\>'<CR>
  \ :Grepper -cword -noprompt<CR>
  \ :cfdo %s/<C-r>s// \| update
  \ <Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>
xmap <Leader>S
  \ "sy \|
  \ :GrepperRg <C-r>s<CR>
  \ :cfdo %s/<C-r>s// \| update
  \ <Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>

" Press * to search for the term under the cursor or a visual selection and
" then press a key below to replace all instances of it in the current file.
nnoremap <leader>r :%s///g<Left><Left><Left>
nnoremap <leader>rc :%s///gc<Left><Left><Left><Left>

" The same as above but instead of acting on the whole file it will be
" restricted to the previously visually selected range. You can do that by
" pressing *, visually selecting the range you want it to apply to and then
" press a key below to replace all instances of it in the current selection.
xnoremap <leader>r :s///g<Left><Left><Left>
xnoremap <leader>rc :s///gc<Left><Left><Left><Left>

" }}}
" ------------------------------------------------------------------
" Telescope {{{
" ------------------------------------------------------------------
lua<< EOF
require('telescope').setup {}
EOF

nnoremap <C-p> :lua require('telescope.builtin').find_files()<CR>
nnoremap <Leader>gf :lua require('telescope.builtin').git_files()<CR>

nnoremap <leader>gr :lua require('telescope.builtin').grep_string { search = vim.fn.expand("<cword>") }<CR>
nnoremap <leader>g :lua require('telescope.builtin').grep_string({ search = vim.fn.input("Grep For > ")})<CR>
nnoremap <leader>b :lua require('telescope.builtin').buffers()<CR>
nnoremap <leader>vh :lua require('telescope.builtin').help_tags()<CR>

" }}}
" ------------------------------------------------------------------
" LSP {{{
" ------------------------------------------------------------------
lua require('init')

autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()

" }}}
" ------------------------------------------------------------------
" RishabhRD/nvim-lsputils') {{{
" ------------------------------------------------------------------

lua <<EOF
vim.lsp.handlers['textDocument/codeAction'] = require'lsputil.codeAction'.code_action_handler
vim.lsp.handlers['textDocument/references'] = require'lsputil.locations'.references_handler
vim.lsp.handlers['textDocument/definition'] = require'lsputil.locations'.definition_handler
vim.lsp.handlers['textDocument/declaration'] = require'lsputil.locations'.declaration_handler
vim.lsp.handlers['textDocument/typeDefinition'] = require'lsputil.locations'.typeDefinition_handler
vim.lsp.handlers['textDocument/implementation'] = require'lsputil.locations'.implementation_handler
vim.lsp.handlers['textDocument/documentSymbol'] = require'lsputil.symbols'.document_handler
vim.lsp.handlers['workspace/symbol'] = require'lsputil.symbols'.workspace_handler
EOF

nnoremap td :lua vim.lsp.buf.definition()<CR>
nnoremap ti :lua vim.lsp.buf.implementation()<CR>
nnoremap tsh :lua vim.lsp.buf.signature_help()<CR>
nnoremap tr :lua vim.lsp.buf.references()<CR>
nnoremap <F2> :lua vim.lsp.buf.rename()<CR>
nnoremap K :lua vim.lsp.buf.hover()<CR>
nnoremap <leader>ca :lua vim.lsp.buf.code_action()<CR>
nnoremap <leader>ld :lua vim.lsp.util.show_line_diagnostics(); vim.lsp.util.show_line_diagnostics()<CR>
nnoremap <leader>lb :lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap <leader>ln :lua vim.lsp.diagnostic.goto_next()<CR>

" }}}
" ------------------------------------------------------------------
" hrsh7th/nvim-compe {{{
" ------------------------------------------------------------------
set completeopt=menuone,noinsert,noselect

" let g:compe = {
"       \ 'enabled': 1,
"       \ 'min_length': 3,
"       \ 'preselect': 'enable',
"       \ 'allow_prefix_unmatch': 0,
"       \ 'source_timeout': 300,
"       \ 'throttle_time': 100,
"       \ 'incomplete_delay': 400,
"       \ 'source': {
"       \   'path': 1,
"       \   'buffer': 1,
"       \   'calc': 1,
"       \   'spell': {
"       \     'filetypes': [
"       \        'markdown',
"       \        'html'
"       \     ]},
"       \   'nvim_lsp': {
"       \     'filetypes': [
"       \       'hbs',
"       \       'javascript',
"       \       'javascriptreact',
"       \       'javascript.jsx',
"       \       'vue',
"       \       'typescript',
"       \       'typescript.tsx',
"       \       'typescriptreact'
"       \     ]}
"       \   }
"       \ }

inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })
inoremap <silent><expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"


" }}}
" -----------------------------------------------------------------------------------------
" lukas-reineke/format.nvim {{{
" -----------------------------------------------------------------------------------------

lua <<EOF
require "format".setup {
    ["*"] = {
        {cmd = {"sed -i 's/[ \t]*$//'"}} -- remove trailing whitespace
    },
    vim = {
        {
            cmd = {"luafmt -w replace"},
            start_pattern = "^lua << EOF$",
            end_pattern = "^EOF$"
        }
    },
    vimwiki = {
        {
            cmd = {"prettier -w --parser babel"},
            start_pattern = "^{{{javascript$",
            end_pattern = "^}}}$"
        }
    },
    lua = {
        {
            cmd = {
                function(file)
                    return string.format("luafmt -l %s -w replace %s", vim.bo.textwidth, file)
                end
            }
        }
    },
    go = {
        {
            cmd = {"gofmt -w", "goimports -w"},
            tempfile_postfix = ".tmp"
        }
    },
    javascript = {
        {cmd = {"prettier -w", "eslint_d --fix"}}
    },
    vue = {
        {cmd = {"prettier -w", "eslint_d --fix"}}
    },
    typescript = {
        {cmd = {"prettier -w", "eslint_d --fix"}}
    },
    markdown = {
        {cmd = {"prettier -w"}},
        {
            cmd = {"black"},
            start_pattern = "^```python$",
            end_pattern = "^```$",
            target = "current"
        }
    }
}
EOF
" }}}
" -----------------------------------------------------------------------------------------
" glepnir/lspsaga.nvim {{{
" -----------------------------------------------------------------------------------------

" TODO: Come back to it when it isn't giving me so many errors
" " lsp provider to find the cursor word definition and reference
" nnoremap <silent> tr <cmd>lua require'lspsaga.provider'.lsp_finder()<CR>
" " or use command LspSagaFinder
" " nnoremap <silent> tr :Lspsaga lsp_finder<CR>

" " preview definition
" nnoremap <silent> td <cmd>lua require'lspsaga.provider'.preview_definition()<CR>
" " or use command
" " nnoremap <silent> td :Lspsaga preview_definition<CR>

" " show signature help
" nnoremap <silent> th <cmd>lua require('lspsaga.signaturehelp').signature_help()<CR>
" " or command
" " nnoremap <silent> gs :Lspsaga signature_help<CR>

" " code action
" nnoremap <silent><leader>ca <cmd>lua require('lspsaga.codeaction').code_action()<CR>
" vnoremap <silent><leader>ca <cmd>'<,'>lua require('lspsaga.codeaction').range_code_action()<CR>
" " or use command
" " nnoremap <silent><leader>ca :Lspsaga code_action<CR>
" " vnoremap <silent><leader>ca :<C-U>Lspsaga range_code_action<CR>

" " show hover doc
" nnoremap <silent> K <cmd>lua require('lspsaga.hover').render_hover_doc()<CR>
" " or use command
" " nnoremap <silent>K :Lspsaga hover_doc<CR>

" " scroll down hover doc or scroll in definition preview
" nnoremap <silent> <C-f> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>
" " scroll up hover doc
" nnoremap <silent> <C-b> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>

" " rename
" nnoremap <silent> <F2> <cmd>lua require('lspsaga.rename').rename()<CR>
" " or command
" " nnoremap <silent>gr :Lspsaga rename<CR>
" " close rename win use <C-c> in insert mode or `q` in noremal mode or `:q`

" " show diagnostics
" nnoremap <silent> ld <cmd>lua require'lspsaga.diagnostic'.show_line_diagnostics()<CR>
" " or use command
" nnoremap <silent> ld :Lspsaga show_line_diagnostics<CR>

" " jump diagnostic
" nnoremap <silent> [e <cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_prev()<CR>
" nnoremap <silent> ]e <cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_next()<CR>
" " or use command
" " nnoremap <silent> [e :Lspsaga diagnostic_jump_next<CR>
" " nnoremap <silent> ]e :Lspsaga diagnostic_jump_prev<CR>

" lua<< EOF

" local saga = require 'lspsaga'

" saga.init_lsp_saga ({
"   use_saga_diagnostic_sign = true,
"   error_sign = '✘',
"   warn_sign = '',
"   infor_sign = '',
" -- dianostic_header_icon = '   ',
" -- code_action_icon = '⻊ ',
" -- code_action_keys = { quit = 'q',exec = '<CR>' }
" -- finder_definition_icon = '  ',
" -- finder_reference_icon = '  ',
" -- max_preview_lines = 10, -- preview lines of lsp_finder and definition preview
" -- finder_action_keys = {
" --   open = 'o', vsplit = 's',split = 'i',quit = 'q',scroll_down = '<C-f>', scroll_up = '<C-b>' -- quit can be a table
" -- },
" -- code_action_keys = {
" --   quit = 'q',exec = '<CR>'
" -- },
" -- rename_action_keys = {
" --   quit = '<C-c>',exec = '<CR>'  -- quit can be a table
" -- },
" -- definition_preview_icon = '丨  '
" -- 1: thin border | 2: rounded border | 3: thick border | 4: ascii border
" -- border_style = 1
" -- rename_prompt_prefix = '➤',
" -- if you don't use nvim-lspconfig you must pass your server name and
" -- the related filetypes into this table
" -- like server_filetype_map = {metals = {'sbt', 'scala'}}
" -- server_filetype_map = {}
" })

" EOF
