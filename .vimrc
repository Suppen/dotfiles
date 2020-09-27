" Requires vim-plug: https://github.com/junegunn/vim-plug. Put plug.vim in ~/.vim/autoload
" After installing vim-plug and this .vimrc, run :PlugInstall in vim

set nocompatible " be iMproved
filetype off     " required

"""""""""""
" Plugins "
"""""""""""

" Keep Plug commands between plug#begin() and plug#end().
call plug#begin()

Plug 'cohama/lexima.vim'          " Auto-close bracketsand the like
Plug 'pangloss/vim-javascript'    " JavaScript support
Plug 'leafgarland/typescript-vim' " TypeScript syntax
Plug 'maxmellon/vim-jsx-pretty'   " JS and JSX syntax
Plug 'jparise/vim-graphql'        " GraphQL syntax
Plug 'neoclide/coc.nvim', {'branch': 'release'} " Loads of useful plugins

" All of your Plugins must be added before the following line
call plug#end()

""""""""
" Misc "
""""""""

" Disable arrow keys, for hard mode
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

" Leader key is SPACE
let mapleader = " "

" Look and feel
set background=dark " Tell vim the background is dark, so it applies correct colors
syntax enable
set t_Co=256 " Enable 256 colors
set wildmenu " Makes a menu appear when pressing <TAB> and there are multiple possibilities
set ttyfast " Tells vim I have a fast TTY
set lazyredraw " Do not redraw when executing macros
set updatetime=300 " Update the cache on disk after this many milliseconds without activity
set mouse=a " Enable mouse
set ttymouse=xterm2 " Make the mouse work properly in tmux
set backspace=indent,eol,start " Make backspace actually work
set ruler " Show the cursor position in the bottom right corner
set scrolloff=5 " Show a few lines above/below the cursor when scrolling to top/bottom
set wrap " Wrap lines
set laststatus=2 " Always show the status line
highlight StatusLine ctermfg=gray ctermbg=16
highlight CocErrorSign ctermfg=11

" Line numbers and signs
set number
set signcolumn=number
highlight LineNr ctermbg=black ctermfg=darkgrey
set colorcolumn=120
set textwidth=0
highlight ColorColumn ctermbg=darkgray

" Search options
set hls is " Highlight all matches when searching
set incsearch " Show matches as a search is being typed

" Tab Options
set shiftwidth=8
set tabstop=8
set softtabstop=8
set noexpandtab

" Delete empty space from the end of lines on every save
autocmd BufWritePre * :%s/\s\+$//e

" Set default encoding to utf-8
set encoding=utf-8
set termencoding=utf-8

" Turn off backup
set nobackup

"""""""
" CoC "
"""""""

" CoC extensions
let g:coc_global_extensions = [
	\'coc-tsserver',
	\'coc-json',
	\'coc-prettier',
	\'coc-eslint',
	\'coc-css',
	\'coc-html'
	\]

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

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Add `:Lint` command, fixing stuff eslint can fix in the current file
command Lint CocCommand eslint.executeAutofix
