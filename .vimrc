" Requires vim-plug: https://github.com/junegunn/vim-plug. Put plug.vim in ~/.vim/autoload
" After installing vim-plug and this .vimrc, run :PlugInstall in vim

set nocompatible    " be iMproved
filetype off

"""""""""""
" Plugins "
"""""""""""

" Keep Plug commands between plug#begin() and plug#end().
call plug#begin()

Plug 'preservim/nerdtree'         " File browser

Plug 'cohama/lexima.vim'          " Auto-close brackets and the like

Plug 'pangloss/vim-javascript'    " JavaScript support
Plug 'leafgarland/typescript-vim' " TypeScript syntax
Plug 'maxmellon/vim-jsx-pretty'   " JS and JSX syntax
Plug 'jparise/vim-graphql'        " GraphQL syntax

Plug 'airblade/vim-gitgutter'     " Git diff on lines edited
Plug 'tpope/vim-fugitive'         " Git support
Plug 'tpope/vim-rhubarb'          " Git support

Plug 'vim-airline/vim-airline'    " Better statusline

Plug 'neoclide/coc.nvim', {'branch': 'release'} " Loads of useful plugins

" All of your Plugins must be added before the following line
call plug#end()
filetype plugin indent on

" CoC extensions
let g:coc_global_extensions = [
	\'coc-tsserver',
	\'coc-json',
	\'coc-css',
	\'coc-html'
	\]

" Add CoC Prettier if prettier is installed
if isdirectory('./node_modules') && isdirectory('./node_modules/prettier')
  let g:coc_global_extensions += ['coc-prettier']
endif

" Add CoC ESLint if ESLint is installed
if isdirectory('./node_modules') && isdirectory('./node_modules/eslint')
  let g:coc_global_extensions += ['coc-eslint']
endif

"""""""""""""
" / Plugins "
"""""""""""""

" Search all subdirectories of the root
set path+=**
" Makes a menu appear when pressing <TAB> and there are multiple possibilities
set wildmenu
" Enable syntax highlighting
syntax enable
" Remember the position in the file when closing it
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Disable arrow keys, for hard mode
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

" Look and feel
set background=dark " Tell vim the background is dark, so it applies correct colors
set t_Co=256 " Enable 256 colors
set ttyfast " Tells vim I have a fast TTY
set lazyredraw " Do not redraw when executing macros
set updatetime=300 " Update the cache on disk after this many milliseconds without activity
set mouse=a " Enable mouse
set ttymouse=xterm2 " Make the mouse work properly in tmux
set backspace=indent,eol,start " Make backspace actually work
set scrolloff=5 " Show a few lines above/below the cursor when scrolling to top/bottom
set laststatus=2 " Always show the status line
highlight StatusLine ctermfg=gray ctermbg=16
highlight CocErrorSign ctermfg=11

" NERDTree
" Start NERDTree and put the cursor back in the other window.
autocmd VimEnter * NERDTree | wincmd p
" If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
    \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif
" Show hidden files
let NERDTreeShowHidden=1
" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif"


" Wrap long lines and treat them as break lines
set wrap
map j gj
map k gk

" Line numbers and signs
set number
set numberwidth=3
set signcolumn=number
set ruler " Show the cursor position in the bottom right corner
highlight LineNr ctermbg=black ctermfg=darkgrey
highlight SignColumn ctermbg=black ctermfg=darkgrey
set colorcolumn=120
set textwidth=0
highlight ColorColumn ctermbg=darkgray
highlight CocFloating ctermbg=237

" Diff
highlight DiffDelete ctermbg=red
highlight DiffAdd ctermbg=darkgreen

" Folding
set foldmethod=syntax
set foldlevel=99
" Enable folding with z
nmap z za

" Search options
set hlsearch " Highlight all matches when searching
set incsearch  " Show matches as a search is being typed
set ignorecase " Ignore case when searching
set smartcase  " Don't ignore case when search contains uppercase chars

" Tab Options
set shiftwidth=4
set tabstop=4
set softtabstop=4
set noexpandtab

" Indentation
set autoindent
set cindent
set smartindent

" Disable bells and whistles
set noerrorbells
set visualbell
set t_vb=

" GitGutter
highlight GitGutterAdd guifg=#009900 ctermfg=2
highlight GitGutterChange guifg=#bbbb00 ctermfg=3
highlight GitGutterDelete guifg=#bbbb00 ctermfg=3

" Allow copy and paste from system clipboard
set clipboard=unnamed

" Delete empty space from the end of lines on every save
autocmd BufWritePre * :%s/\s\+$//e

" Set default encoding to utf-8
set encoding=utf-8
set termencoding=utf-8

" Turn off backup
set nobackup
set writebackup
set noswapfile

" Make it possible to hide buffers without saving them
set hidden

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Use tab for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Leader key is SPACE
let mapleader = " "

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)
" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Add `:Lint` command, fixing stuff eslint can fix in the current file
command Lint CocCommand eslint.executeAutofix
