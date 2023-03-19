-- Requires vim-plug: https://github.com/junegunn/vim-plug. Put plug.vim in
-- ~/.local/share/nvim/site/autoload/
-- After installing vim-plug and this init.lua, run :PlugInstall in nvim
vim.cmd([[
" Keep Plug commands between plug#begin() and plug#end().
call plug#begin()

" Download and install a NerdFont too: https://github.com/ryanoasis/nerd-fonts/releases/tag/v2.3.3
" Konsole uses the font called Hack
Plug 'lukas-reineke/indent-blankline.nvim'  " Visualise line indents

Plug 'nvim-tree/nvim-web-devicons' " Fancy icons

Plug 'nvim-tree/nvim-tree.lua'    " File browser

Plug 'windwp/nvim-autopairs'      " Automatically pair certain characters
Plug 'windwp/nvim-ts-autotag'     " Automatically pair html (and html-ish) tags

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} " Syntax highlighting

Plug 'tpope/vim-surround'         " Surrond stuff with other stuff

Plug 'airblade/vim-gitgutter'     " Git diff on lines edited
Plug 'tpope/vim-fugitive'         " Git support

Plug 'nvim-lualine/lualine.nvim'  " Better statusline

Plug 'preservim/nerdcommenter'    " Comment/uncomment stuff

Plug 'tpope/vim-repeat'           " Repeat plugin commands

Plug 'EdenEast/nightfox.nvim'     " Fancy color theme

Plug 'nvim-lua/plenary.nvim'      " Dependency of telescope
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.1' } " Fuzzy search

Plug 'phaazon/hop.nvim'           " Hop directly to where you want to be

" Snippet engine
Plug 'L3MON4D3/LuaSnip', {'tag': 'v<CurrentMajor>.*', 'do': 'make install_jsregexp'}
Plug 'saadparwaiz1/cmp_luasnip'   " Snippet engine
Plug 'rafamadriz/friendly-snippets' " Snippet collection

Plug 'williamboman/mason.nvim'    " Package manager
Plug 'williamboman/mason-lspconfig.nvim' " Bridge between Mason and lspconfig
Plug 'neovim/nvim-lspconfig'      " LSP configs

Plug 'hrsh7th/nvim-cmp'           " Autocompletion
Plug 'hrsh7th/cmp-nvim-lsp'

" All of your Plugins must be added before the following line
call plug#end()
]])
