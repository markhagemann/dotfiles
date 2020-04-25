if &compatible
  set nocompatible
endif
" ------------------------------------------------------------------
" Plugins
" ------------------------------------------------------------------

" Add the dein installation directory into runtimepath
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

" Define plugins for dein to install
if dein#load_state('~/.cache/dein')
  call dein#begin('~/.cache/dein')
  call dein#add('~/.cache/dein/repos/github.com/Shougo/dein.vim')

  " Autocompletion
  call dein#add('neoclide/coc.nvim', {'merged':0, 'rev': 'release'})
  call dein#add('jiangmiao/auto-pairs')
  call dein#add('alvan/vim-closetag')
  " Buffer / File searching and replacing
  call dein#add('Yggdroot/LeaderF')
  call dein#add('mhinz/vim-grepper')
  call dein#add('haya14busa/is.vim')
  " Colorscheme
  call dein#add('arcticicestudio/nord-vim')
  call dein#add('tyrannicaltoucan/vim-deep-space')
  " Comment out blocks of code
  call dein#add('tomtom/tcomment_vim')
  " Docker
  call dein#add('ekalinin/Dockerfile.vim')
  " Editorconfig per project basis
  call dein#add('editorconfig/editorconfig-vim')
  " File manager
  call dein#add('shougo/defx.nvim')
  call dein#add('kristijanhusak/defx-icons')
  call dein#add('kristijanhusak/defx-git')
  " Folds.
  call dein#add('Konfekt/Fastfold')
  " Git
  call dein#add('mhinz/vim-signify')
  call dein#add('tpope/vim-fugitive')
  call dein#add('christoomey/vim-conflicted')
  call dein#add('APZelos/blamer.nvim')
  " IndentLine
  call dein#add('Yggdroot/indentLine')
  " call dein#add('lukas-reineke/indent-blankline.nvim')
  " Language support
  call dein#add('elzr/vim-json')
  call dein#add('pangloss/vim-javascript')
  call dein#add('sheerun/vim-polyglot')
  call dein#add('kristijanhusak/vim-js-file-import')
  " Move lines around easy
  call dein#add('matze/vim-move')
  " Undotree
  call dein#add('mbbill/undotree')
  " Whitespace removal
  call dein#add('ntpeters/vim-better-whitespace')
  " Smooth scroll
  call dein#add('psliwka/vim-smoothie')
  " Status bar
  call dein#add('vim-airline/vim-airline')

  if !has('nvim')
    call dein#add('roxma/nvim-yarp')
    call dein#add('roxma/vim-hug-neovim-rpc')
  endif

  call dein#end()
  call dein#save_state()
endif

" ------------------------------------------------------------------
" General
" ------------------------------------------------------------------

syntax on
filetype plugin indent on
set nowrap
set noswapfile
set nobackup
set undodir=~/.config/nvim/undodir
set undofile
set incsearch
set smartindent
set splitright
set splitbelow
set autoindent
set wildmenu
set wildmode=full
set mouse=a

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Give more space for displaying messages.
set cmdheight=1

" Don't show last command
set noshowcmd

" Automatically re-read file if a change was detected outside of vim
set autoread

" If the search string has an upper case letter in it, the search will be case sensitive
set smartcase

" Show existing tab with 2 spaces width
set tabstop=2 softtabstop=2

" When indenting with '>', use 2 spaces width
set shiftwidth=2

" On pressing tab, insert 2 spaces
set expandtab

" Hide buffer instead of closing it
set hidden

" Disable annoying beeping
set noerrorbells

" Use hybrid numbers
set nu rnu

" Yank and paste with the system clipboard
set clipboard=unnamedplus

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=100

let mapleader = " "
nnoremap <leader>u :UndotreeShow<CR>

" Edit Vim config file in a new tab.
map <leader>ev :tabnew $MYVIMRC<CR>

" Clear highlighting on escape in normal mode - TODO: Validate this is still working
nnoremap <esc> :noh<return><esc>
nnoremap <esc>^[ <esc>^[

" Delete current visual selection and dump in black hole buffer before pasting
" Used when you want to paste over something without it getting copied to
" Vim's default buffer
vnoremap <leader>p "_dP

" Show whitespace as characters
set list!
set listchars=nbsp:·,trail:~

" Add custom highlights in method that is executed every time a colorscheme is sourced
" See https://gist.github.com/romainl/379904f91fa40533175dfaec4c833f2f for details
function! TrailingSpaceHighlights() abort
  " Hightlight trailing whitespace
  highlight Trail ctermbg=red guibg=red
  call matchadd('Trail', '\s\+$', 100)
endfunction

" Seamlessly treat visual lines as actual lines when moving around.
noremap j gj
noremap k gk
noremap <Down> gj
noremap <Up> gk
inoremap <Down> <C-o>gj
inoremap <Up> <C-o>gk

" Navigate around splits with a single key combo.
nnoremap <C-l> <C-w><C-l>
nnoremap <C-h> <C-w><C-h>
nnoremap <C-k> <C-w><C-k>
nnoremap <C-j> <C-w><C-j>

" Cycle through splits.
nnoremap <S-Tab> <C-w>w

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
set termguicolors
set numberwidth=2
set foldcolumn=2
colorscheme nord
let g:nord_cursor_line_number_background = 1
hi! Normal ctermbg=NONE guibg=NONE
hi! NonText ctermbg=NONE guibg=NONE guifg=NONE ctermfg=NONE
hi! SignColumn ctermbg=NONE guibg=NONE guifg=NONE ctermfg=NONE
hi! LineNr cterm=NONE ctermfg=grey ctermbg=NONE gui=NONE guifg=#7a5a5a guibg=NONE
hi! Cursor cterm=NONE ctermbg=darkblue ctermfg=cyan guibg=NONE guifg=#2a4e84
hi! CursorLineNR cterm=NONE ctermbg=NONE ctermfg=darkred guibg=NONE guifg=#f28c8c
hi LineNr guibg=bg
hi foldcolumn guibg=bg
hi VertSplit guibg=NONE guifg=#151b23

autocmd BufNewFile,BufRead * setlocal formatoptions-=cro

" Enable spellcheck for markdown files
autocmd BufRead,BufNewFile *.md setlocal spell

" ------------------------------------------------------------------
" File manager settings
" ------------------------------------------------------------------
nnoremap <C-n> :Defx -show-ignored-files<CR>
nnoremap <C-d> :Defx `expand('%:p:h')` -show-ignored-files -search=`expand('%:p')`<CR>
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
call defx#custom#column('icon', {
    \ 'directory_icon': '▸',
    \ 'opened_icon': '▾',
    \ })

augroup defx-extensions
  autocmd!
  " Close defx if it's the only buffer left in the window
  " autocmd WinEnter * if &ft == 'defx' && winnr('$') == 1 | q | endif
  " Move focus to the next window if current buffer is defx
  autocmd TabLeave * if &ft == 'defx' | wincmd w | endif
  autocmd FileType defx do WinEnter | call s:defx_my_settings()
augroup END

autocmd FileType defx call s:defx_my_settings()
function! s:defx_my_settings() abort
  setlocal conceallevel=3
  setlocal concealcursor=inc
  " Define mappings
  nnoremap <silent><buffer><expr> <CR> defx#do_action('drop')
  nnoremap <silent><buffer><expr> c
  \ defx#do_action('copy')
  nnoremap <silent><buffer><expr> m
  \ defx#do_action('move')
  nnoremap <silent><buffer><expr> p
  \ defx#do_action('paste')
  nnoremap <silent><buffer><expr> V
  \ defx#do_action('open', 'vsplit')
  nnoremap <silent><buffer><expr> H
  \ defx#do_action('drop', 'pedit')
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
  nnoremap <silent><buffer><expr> j
  \ line('.') == line('$') ? 'gg' : 'j'
  nnoremap <silent><buffer><expr> k
  \ line('.') == 1 ? 'G' : 'k'
  nnoremap <silent><buffer><expr> l defx#do_action('drop')
  " nnoremap <silent><buffer><expr> <C-l>
  " \ defx#do_action('redraw')
  nnoremap <silent><buffer><expr> <C-g>
  \ defx#do_action('print')
  nnoremap <silent><buffer><expr> cd
  \ defx#do_action('change_vim_cwd')
endfunction

" ------------------------------------------------------------------
" vim-airline/vim-airline
" ------------------------------------------------------------------
let g:airline_theme = 'nord'
let g:airline#extensions#branch#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline#extensions#tmuxline#enabled = 1
let g:airline#extensions#tabline#enabled = 1 " Enable the list of buffers
let g:airline#extensions#tabline#buffers_label = ''
let g:airline#extensions#tabline#fnamemod = ':t' " Show the filename
let g:airline#extensions#tabline#fnamecollapse = 0
let g:airline#extensions#tabline#show_tab_nr = 0
let g:airline#extensions#tabline#buffer_nr_show = 0
let g:airline#extensions#tabline#show_close_button = 0
let g:airline#extensions#coc#enabled = 0
" let g:airline_left_sep = ''
" let g:airline_left_alt_sep = ''
" let g:airline_right_sep = ''
" let g:airline_right_alt_sep = ''
let g:airline#extensions#default#layout = [
  \ [ 'a', 'c' ],
  \ [ 'x', 'error', 'warning' ]
  \ ]

" ------------------------------------------------------------------
" editorconfig/editorconfig
" ------------------------------------------------------------------
let g:EditorConfig_max_line_indicator = "none"
let g:EditorConfig_preserve_formatoptions = 1

" ------------------------------------------------------------------
" Yggdroot/LeaderF
" ------------------------------------------------------------------
" let g:Lf_HideHelp = 1
let g:Lf_WindowPosition = 'popup'
let g:Lf_UseCache = 0
let g:Lf_UseVersionControlTool = 0
let g:Lf_IgnoreCurrentBufferName = 1

let g:Lf_ShortcutF = "<C-P>"
noremap <leader>fb :<C-U><C-R>=printf("Leaderf buffer %s", "")<CR><CR>
noremap <leader>fm :<C-U><C-R>=printf("Leaderf mru %s", "")<CR><CR>
noremap <leader>fl :<C-U><C-R>=printf("Leaderf line %s", "")<CR><CR>

noremap <C-B> :<C-U><C-R>=printf("Leaderf! rg --current-buffer -e %s ", expand("<cword>"))<CR>
noremap <C-F> :<C-U><C-R>=printf("Leaderf! rg -e %s ", expand("<cword>"))<CR>
" search visually selected text literally
xnoremap gf :<C-U><C-R>=printf("Leaderf! rg -F -e %s ", leaderf#Rg#visual())<CR>
noremap go :<C-U>Leaderf! rg --recall<CR>

" ------------------------------------------------------------------
" pangloss/vim-javascript settings
" ------------------------------------------------------------------
let g:javascript_plugin_jsdoc = 1

" ------------------------------------------------------------------
" Konfekt/FastFold
" ------------------------------------------------------------------

let g:fastfold_savehook=0
let g:fastfold_fold_command_suffixes=[]

" ------------------------------------------------------------------
" neoclide/coc.nvim
" ------------------------------------------------------------------
let g:coc_global_extensions = ['coc-eslint', 'coc-tsserver', 'coc-json', 'coc-prettier', 'coc-vetur', 'coc-html', 'coc-css', 'coc-highlight']
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <cr> to confirm completion
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> td <Plug>(coc-definition)
nmap <silent> ty <Plug>(coc-type-definition)
nmap <silent> ti <Plug>(coc-implementation)
nmap <silent> tr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <F2> <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current line.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Introduce function text object
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <TAB> for selections ranges.
" NOTE: Requires 'textDocument/selectionRange' support from the language server.
" coc-tsserver, coc-python are the examples of servers that support it.
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings using CoCList:
" Show all diagnostics.
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

" ------------------------------------------------------------------
" mhinz/vim-grepper
" ------------------------------------------------------------------

let g:grepper={}
let g:grepper.tools=["rg"]

xmap gr <plug>(GrepperOperator)

" After searching for text, press this mapping to do a project wide find and
" replace. It's similar to <leader>r except this one applies to all matches
" across all files instead of just the current file.
nnoremap <leader>R
  \ :let @s='\<'.expand('<cword>').'\>'<CR>
  \ :Grepper -cword -noprompt<CR>
  \ :cfdo %s/<C-r>s//g \| update
  \<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>

" The same as above except it works with a visual selection.
xmap <leader>R
    \ "sy
    \ gvgr
    \ :cfdo %s/<C-r>s//g \| update
     \<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>

" ------------------------------------------------------------------
" ntpeters/vim-better-whitespace
" ------------------------------------------------------------------

let g:strip_whitespace_confirm=0
let g:strip_whitespace_on_save=1

" ------------------------------------------------------------------
" alvan/vim-closetag
" ------------------------------------------------------------------
" filenames like *.xml, *.html, *.xhtml, ...
" These are the file extensions where this plugin is enabled.
let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.jsx,*.tsx'

" integer value [0|1]
" This will make the list of non-closing tags case-sensitive (e.g. `<Link>` will be closed while `<link>` won't.)
let g:closetag_emptyTags_caseSensitive = 1

" ------------------------------------------------------------------
" Indent settings
" ------------------------------------------------------------------
let g:indentLine_char_list = ['▏']
let g:indentLine_color_gui = '#453c47'
let g:vim_json_syntax_conceal = 0

" ------------------------------------------------------------------
" APZelos/blamer.nvim
" ------------------------------------------------------------------
let g:blamer_enabled = 1
let g:blamer_delay = 500
let g:blamer_show_in_visual_modes = 0
