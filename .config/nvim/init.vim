" ------------------------------------------------------------------
" General {{{
" ------------------------------------------------------------------
filetype plugin on
let g:mapleader=" "
syntax enable                           " Enables syntax highlighing
set completeopt=menu,menuone,noselect   " Better autocomplete options
set mouse=a                             " Enable your mouse
set splitbelow                          " Horizontal splits will automatically be below
set splitright                          " Vertical splits will automatically be to the right
set expandtab                           " Converts tabs to spaces
set number                              " Line numbers
set rnu                                 " Relative line numbers
set ignorecase smartcase                " Ignore case only when the pattern contains no capital letters
set incsearch                           " Search incremental
set hidden                              " Required to keep multiple buffers open multiple buffers
set shell=zsh                           " Set shell to zsh
set iskeyword+=-                        " Treat dash separated words as a word text object
setlocal formatoptions-=cro             " Stop newline continution of comments
set nowrap                              " Display long lines as just one line
set encoding=utf-8                      " The encoding displayed
set fileencoding=utf-8                  " The encoding written to file
set nobackup                            " Don't create backup files
set nowritebackup                       " Don't create backup files
set undofile                            " Persistent Undo
set pumheight=20                        " Makes popup menu smaller
set ruler                               " Show the cursor position all the time
set cmdheight=1                         " More space for displaying messages
set shortmess+=c                        " Don't pass messages to |ins-completion-menu|.
set noshowcmd                           " Don't show entered command
set noshowmode                          " Don't show mode - handled by lightline
set t_Co=256                            " Support 256 colors
set smarttab                            " Makes tabbing smarter will realize you have 2 vs 4
set smartindent                         " Makes indenting smart
set autoindent                          " Good auto indent
set laststatus=2                        " Always display the status line
set scrolloff=6                         " Keep 6 lines above/below cursor
set cursorline                          " Enable highlighting of the current line
set background=dark                     " tell vim what the background color looks like
set nobackup                            " This is recommended by coc
set nowritebackup                       " This is recommended by coc
set signcolumn=yes                      " Always show the signcolumn, otherwise it would shift the text each time
set updatetime=300                      " Faster completion
set timeoutlen=500                      " By default timeoutlen is 1000 ms
set clipboard=unnamedplus               " Copy paste between vim and everything else

" ------------------------------------------------------------------
" Mappings {{{
" ------------------------------------------------------------------

" You can't stop me
cmap w!! w !sudo tee %

" Edit Vim config file in a new tab.
map <leader>ev :tabnew $MYVIMRC<CR>

" Remap macro record key
nnoremap Q q
nnoremap q <Nop>

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

" ------------------------------------------------------------------
" Plugins {{{
" ------------------------------------------------------------------
if &compatible
  call dein#add('voldikss/vim-floaterm')
  set nocompatible
endif

" Add the dein installation directory into runtimepath
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

" Define plugins for dein to install
if dein#load_state('~/.cache/dein')
  call dein#begin('~/.cache/dein')
  call dein#add('~/.cache/dein/repos/github.com/Shougo/dein.vim')

  " Autocompletion
  call dein#add('Raimondi/delimitMate')
  " Colorscheme
  call dein#add('ayu-theme/ayu-vim')
  call dein#add('TaDaa/vimade')
  " Colorizer
  call dein#add('norcalli/nvim-colorizer.lua')
  call dein#add('junegunn/rainbow_parentheses.vim')
  " Comment out blocks of code
  call dein#add('tpope/vim-commentary')
  " Debugging
  call dein#add('mfussenegger/nvim-dap')
  " File manager
  call dein#add('junegunn/fzf', { 'build': './install --all', 'merged': 0  })
  call dein#add('junegunn/fzf.vim', { 'depends': 'fzf'  })
  call dein#add('shougo/defx.nvim')
  call dein#add('kristijanhusak/defx-icons')
  call dein#add('airblade/vim-rooter')
  " File searching and replacing
  call dein#add('brooth/far.vim')
  " Floating Terminal / Window Management
  call dein#add('voldikss/vim-floaterm')
  " Git
  call dein#add('tpope/vim-fugitive')
  call dein#add('airblade/vim-gitgutter')
  call dein#add('itchyny/vim-gitbranch')
  call dein#add('APZelos/blamer.nvim')
  " IndentLine
  call dein#add('Yggdroot/indentLine')
  call dein#add('lukas-reineke/indent-blankline.nvim', { 'rev': 'master' })
  " Language support
  call dein#add('neovim/nvim-lspconfig')
  call dein#add('hrsh7th/nvim-compe')
  call dein#add('RishabhRD/popfix')
  call dein#add('RishabhRD/nvim-lsputils')
  call dein#add('tpope/vim-sleuth')
  call dein#add('sbdchd/neoformat')
  call dein#add('elzr/vim-json')
  call dein#add('plasticboy/vim-markdown')
  " Scratchpad
  call dein#add('Konfekt/vim-scratchpad')
  " Status bar
  call dein#add('itchyny/lightline.vim')
  call dein#add('sinetoami/lightline-hunks')
  " Text navigation / manipulation
  call dein#add('chaoren/vim-wordmotion')
  call dein#add('machakann/vim-sandwich')
  " Vim monitoring
  call dein#add('dstein64/vim-startuptime')
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
" Autocmd {{{
" ------------------------------------------------------------------
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
autocmd BufNewFile,BufRead * setlocal formatoptions-=cro
" Enable spellcheck for markdown files
autocmd BufRead,BufNewFile *.md setlocal spell
" Try fix syntax highlighting issues on large files
autocmd BufEnter *.{js,ts,jsx,tsx,vue} :syntax sync fromstart
" }}}
" ------------------------------------------------------------------
" Syntax Highlight {{{
" ------------------------------------------------------------------
let g:markdown_fenced_languages = ['javascript', 'js=javascript', 'json=javascript'] " syntax highlighting in markdown
" }}}
" ------------------------------------------------------------------
" Colorscheme {{{
" ------------------------------------------------------------------
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
hi VertSplit guibg=NONE guifg=#151b23
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
" itchyny/lightline.vim and itchyny/vim-gitbranch
let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'filename': 'LightlineFilename',
      \   'gitbranch': 'gitbranch#name'
      \ },
      \ 'colorscheme': 'ayu',
      \ }

function! LightlineFilename()
  let root = fnamemodify(get(b:, 'git_dir'), ':h')
  let path = expand('%:p')
  if path[:len(root)-1] ==# root
    return path[len(root)+1:]
  endif
  return expand('%')
endfunction
" }}}
" ------------------------------------------------------------------
" sbdchd/neoformat {{{
" ------------------------------------------------------------------
let g:neoformat_vue_eslint_d = {
        \ 'exe': 'eslint_d',
        \ 'args': ['--stdin', '--stdin-filename', '"%:p"', '--fix-to-stdout'],
        \ 'stdin': 1,
        \ }

let g:neoformat_enabled_javascript = ['prettier', 'eslint_d']
let g:neoformat_enabled_typescript = ['prettier', 'eslint_d']
let g:neoformat_enabled_vue = ['prettier', 'eslint_d']
nnoremap <leader>f :Neoformat eslint_d<CR>
vnoremap <Leader>f :Neoformat eslint_d<CR>
"}}}
" ------------------------------------------------------------------
" junegunn/fzf.vim
" ------------------------------------------------------------------
map <C-p> :Files<CR>
nnoremap <leader>p :Files<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>g :Rg<CR>
nnoremap <leader>hh :History:<CR>
inoremap <expr> <c-x><c-f> fzf#vim#complete#path(
    \ "find . -path '*/\.*' -prune -o -print \| sed '1d;s:^..::'",
    \ fzf#wrap({'dir': expand('%:p:h')}))
if has('nvim')
  au! TermOpen * tnoremap <buffer> <Esc> <c-\><c-n>
  au! FileType fzf tunmap <buffer> <Esc>
endif

"Get Files
command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse', '--info=inline']}), <bang>0)

" Use ripgrep instead of grep
set grepprg=rg\ --vimgrep\ --smart-case\ --follow

let $FZF_DEFAULT_OPTS = '--layout=reverse --info=inline'
let $FZF_DEFAULT_COMMAND="rg --files --hidden"

" Border color
let g:fzf_layout = {'up':'~90%', 'window': { 'width': 0.85, 'height': 0.85,'yoffset':0.5,'xoffset': 0.5, 'border': 'sharp' } }

" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" Make Ripgrep ONLY search file contents and not filenames
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --hidden --smart-case --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'up:60%')
  \           : fzf#vim#with_preview({'options': '--delimiter : --nth 4.. -e'}, 'right:40%', '?'),
  \   <bang>0)

" }}}
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
let g:indentLine_char_list = ['▏']
let g:indentLine_color_gui = '#453c47'
let g:indentLine_leadingSpaceEnabled = 1
let g:indentLine_leadingSpaceChar = ' '
let g:indentLine_fileTypeExclude = ['json', 'md']

" Markdown
let g:vim_markdown_conceal = 0
let g:vim_markdown_conceal_code_blocks = 0

" Json
let g:vim_json_syntax_conceal = 0
let g:vim_json_conceal = 0

" Show whitespace as characters
set list!
" set listchars=eol:↴
set listchars+=tab:│⋅
set listchars+=trail:~
set listchars+=extends:❯
set listchars+=precedes:❮
set listchars+=nbsp:_
" set listchars+=space:⋅

" }}}
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
let g:rainbow#max_level = 4
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
" LSP {{{
" ------------------------------------------------------------------
" lua require('init')
lua require'lspconfig'.tsserver.setup{}
lua require'lspconfig'.vuels.setup{}

lua << EOF

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    -- This will disable virtual text, like doing:
    -- let g:diagnostic_enable_virtual_text = 0
    virtual_text = false,

    -- This is similar to:
    -- let g:diagnostic_show_sign = 1
    -- To configure sign display,
    --  see: ":help vim.lsp.diagnostic.set_signs()"
    signs = true,

    -- This is similar to:
    -- "let g:diagnostic_insert_delay = 1"
    update_in_insert = false,
  }
)

local eslint = {
    lintCommand = "eslint_d -f unix --stdin --stdin-filename ${INPUT}",
    lintStdin = true,
    lintFormats = {"%f:%l:%c: %m"},
    lintIgnoreExitCode = true,
    formatCommand = "eslint_d --fix-to-stdout --stdin --stdin-filename=${INPUT}",
    formatStdin = true
}

require'lspconfig'.efm.setup{
    on_attach = on_attach,
    init_options = {documentFormatting = true},
    settings = {
        rootMarkers = {".git/"},
        languages = {
            vue = {eslint},
            typescript = {eslint},
            javascript = {eslint},
            typescriptreact = {eslint},
            javascriptreact = {eslint}
        }
    }
}
EOF

" lua require'lspconfig'.vuels.setup {
"     on_attach = on_attach
" }

nnoremap <silent> ld                    <cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>
nnoremap <silent> td                    <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K                     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> <leader>ca            <cmd>lua vim.lsp.buf.code_action()<CR>
nnoremap <silent> ti                    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> th                    <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> tr                    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> <F2>                  <cmd>lua vim.lsp.buf.rename()<CR>
" }}}
" ------------------------------------------------------------------
" 'hrsh7th/nvim-compe'
" ------------------------------------------------------------------
lua << EOF
require'compe'.setup {
  enabled = true;
  autocomplete = true;
  source = {
    path = true;
    buffer = true;
    nvim_lsp = true;
    nvim_lua = true;
    -- treesitter = true;
  };
}
EOF
" }}}
" ------------------------------------------------------------------
" RishabhRD/nvim-lsputils
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

inoremap <silent><expr> <C-Space> compe#complete()
inoremap <silent><expr> <CR>      compe#confirm('<CR>')
" inoremap <silent><expr> <C-e>     compe#close('<C-e>')
" inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
" inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })
inoremap <silent><expr> <TAB>     pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB>            pumvisible() ? "\<C-p>" : "\<C-h>"
" }}}
" ------------------------------------------------------------------
" mfussenegger/nvim-dap
" ------------------------------------------------------------------
lua << EOF
local dap = require('dap')
dap.adapters.node2 = {
  type = 'executable',
  command = 'node',
  args = {os.getenv('HOME') .. '/vscode-node-debug2/out/src/nodeDebug.js'},
}
vim.fn.sign_define('DapBreakpoint', {text='🟥', texthl='', linehl='', numhl=''})
vim.fn.sign_define('DapStopped', {text='🟢', texthl='', linehl='', numhl=''})
EOF
nnoremap <leader>dh :lua require'dap'.toggle_breakpoint()<CR>
nnoremap <S-k> :lua require'dap'.step_out()<CR>
nnoremap <S-l> :lua require'dap'.step_into()<CR>
nnoremap <S-j> :lua require'dap'.step_over()<CR>
nnoremap <leader>dn :lua require'dap'.continue()<CR>
nnoremap <leader>d_ :lua require'dap'.run_last()<CR>
nnoremap <leader>dr :lua require'dap'.repl.open({}, 'vsplit')<CR><C-w>l
nnoremap <leader>di :lua require'dap.ui.variables'.hover(function () return vim.fn.expand("<cexpr>") end)<CR>
vnoremap <leader>di :lua require'dap.ui.variables'.visual_hover()<CR>
nnoremap <leader>d? :lua require'dap.ui.variables'.scopes()<CR>
nnoremap <leader>de :lua require'dap'.set_exception_breakpoints({"all"})<CR>
nnoremap <leader>da :lua require'debugHelper'.attach()<CR>
" }}}
