-- Requires vim-plug: https://github.com/junegunn/vim-plug. Put plug.vim in
-- ~/.local/share/nvim/site/autoload/
-- After installing vim-plug and this init.lua, run :PlugInstall in nvim
vim.cmd([[
" Keep Plug commands between plug#begin() and plug#end().
call plug#begin()

" Download and install a NerdFont too: https://github.com/ryanoasis/nerd-fonts/releases/tag/v2.3.3
" Konsole uses the font called Hack
Plug 'lukas-reineke/indent-blankline.nvim'  " Visualize line indents

Plug 'nvim-tree/nvim-web-devicons' " Fancy icons

Plug 'nvim-tree/nvim-tree.lua'    " File browser

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} " Syntax highlighting

Plug 'tpope/vim-surround'         " Surrond stuff with other stuff

Plug 'rust-lang/rust.vim'         " Rust support

Plug 'neovimhaskell/haskell-vim'  " Haskell support

Plug 'airblade/vim-gitgutter'     " Git diff on lines edited
Plug 'tpope/vim-fugitive'         " Git support

Plug 'nvim-lualine/lualine.nvim'  " Better statusline

Plug 'preservim/nerdcommenter'    " Comment/uncomment stuff

Plug 'tpope/vim-repeat'           " Repeat plugin commands

Plug 'neoclide/coc.nvim', {'branch': 'release'} " Loads of useful plugins

Plug 'EdenEast/nightfox.nvim'     " Fancy color theme

Plug 'nvim-lua/plenary.nvim'      " Dependency of telescope
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.1' } " Fuzzy search

Plug 'phaazon/hop.nvim'

" All of your Plugins must be added before the following line
call plug#end()
]])
