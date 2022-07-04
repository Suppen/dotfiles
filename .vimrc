set nocompatible    " be iMproved
filetype off

"""""""""""
" Plugins "
"""""""""""

" Requires vim-plug: https://github.com/junegunn/vim-plug. Put plug.vim in ~/.vim/autoload
" After installing vim-plug and this .vimrc, run :PlugInstall in vim

" Keep Plug commands between plug#begin() and plug#end().
call plug#begin()

Plug 'preservim/nerdtree'         " File browser

" Download and install a NerdFont too: https://github.com/ryanoasis/nerd-fonts/releases/tag/v2.1.0
" Konsole uses the font called Hack
Plug 'ryanoasis/vim-devicons'     " Fancy icons

Plug 'tpope/vim-surround'         " Surrond stuff with other stuff

Plug 'pangloss/vim-javascript'    " JavaScript support
Plug 'leafgarland/typescript-vim' " TypeScript syntax
Plug 'maxmellon/vim-jsx-pretty'   " JS and JSX syntax
Plug 'jparise/vim-graphql'        " GraphQL syntax

Plug 'rust-lang/rust.vim'         " Rust support

Plug 'airblade/vim-gitgutter'     " Git diff on lines edited
Plug 'tpope/vim-fugitive'         " Git support

Plug 'vim-airline/vim-airline'    " Better statusline

Plug 'tpope/vim-commentary'       " Comment/uncomment stuff

Plug 'tpope/vim-repeat'           " Repeat plugin commands

Plug 'neoclide/coc.nvim', {'branch': 'release'} " Loads of useful plugins

" Requires fzf to be installed on the system to work
Plug 'junegunn/fzf'               " Set up fzf and fzf.vim
Plug 'junegunn/fzf.vim'

" All of your Plugins must be added before the following line
call plug#end()
filetype plugin indent on

" CoC extensions
let g:coc_global_extensions = [
	\'coc-pairs',
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

" Wrap long lines and treat them as break lines
set wrap
map j gj
map k gk

" Line numbers and signs
set number
set numberwidth=3
set signcolumn=yes
set relativenumber " Show line numbers as relative to the current one
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

" Give more space for displaying messages
set cmdheight=2

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call ShowDocumentation()<CR>
function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedKeys('K', 'in')
  endif
endfunction

" Use tab for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ CheckBackspace() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')

" Autoformat on save
let g:rustfmt_autosave = 1

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Leader key is SPACE
let mapleader = ' '

" Symbol renaming.
nnoremap <silent> <leader>rn   <Plug>(coc-rename)
" Quick access to CocAction
nnoremap <silent> <leader>ac   <Plug>(coc-codeaction)
" Apply codelens action to current line
nnoremap <silent> <leader>cl   <Plug>(coc-codelens-action)
" Quick access to CocCommand
nnoremap <silent> <leader>c    :<C-u>CocList commands<CR>
" Apply AutoFix to problem on the current line.
nnoremap <silent> <leader>qf   <Plug>(coc-fix-current)
" Show outline of current file
nnoremap <silent> <leader>o    :<C-u>CocList outline<CR>
" List open buffers
nnoremap <silent> <leader>l    :<C-u>Buffers<CR>
" List files
nnoremap <silent> <leader>f    :<C-u>Files<CR>

" NERDTree
" Show hidden files
let NERDTreeShowHidden=1
" Toggle NERDTree
nnoremap <silent> <leader>nt   :NERDTreeToggle<CR>

" Add `:Lint` command, fixing stuff eslint can fix in the current file
command Lint CocCommand eslint.executeAutofix
