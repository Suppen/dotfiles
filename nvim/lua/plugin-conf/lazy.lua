-- Install and load lazy, a plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Load lazy
local status_ok, lazy = pcall(require, "lazy")
if not status_ok then
	print "Failed to load lazy.nvim"
	return
end

-- Load plugins
lazy.setup({
	-- Fancy color theme
	{
		'EdenEast/nightfox.nvim',
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd [[colorscheme nightfox]]
		end
	},

	{
		-- Visualise line indents
		'lukas-reineke/indent-blankline.nvim',
		main = 'ibl'
	},
	'nvim-tree/nvim-web-devicons',      -- Fancy icons
	'nvim-tree/nvim-tree.lua',          -- File browser
	{
		-- Syntax highlighting
		'nvim-treesitter/nvim-treesitter',
		build = ':TSUpdate'
	},
	{
		-- Automatically pair certain characters
		'windwp/nvim-autopairs',
		event = 'InsertEnter'
	},
	'windwp/nvim-ts-autotag', -- Automatically pair html (and html-ish) tags
	'tpope/vim-surround',  -- Surrond stuff with other stuff
	{
		-- Show errors in a floating window
		'folke/trouble.nvim',
		dependencies = {
			'nvim-tree/nvim-web-devicons'
		}
	},
	'airblade/vim-gitgutter', -- Git diff on lines edited
	'tpope/vim-fugitive',  -- Git support
	{
		-- Better statusline
		'nvim-lualine/lualine.nvim',
		dependencies = {
			'nvim-tree/nvim-web-devicons'
		},
	},
	'preservim/nerdcommenter', -- Comment/uncomment stuff
	'tpope/vim-repeat',     -- Repeat plugin commands

	-- Fuzzy search
	{
		'nvim-telescope/telescope.nvim',
		tag = '0.1.4',
		dependencies = {
			'nvim-lua/plenary.nvim',
			'nvim-telescope/telescope-fzy-native.nvim',
		},
	},

	-- Language server stuff
	'williamboman/mason.nvim',        -- Package manager
	'williamboman/mason-lspconfig.nvim', -- Bridge between Mason and lspconfig
	'neovim/nvim-lspconfig',          -- LSP configs
	'jose-elias-alvarez/null-ls.nvim', -- LSP configs for non-LSP languages

	-- Snippet stuff
	{
		-- Snippet engine
		'L3MON4D3/LuaSnip',
		version = 'v2.*',
		build = 'make install_jsregexp'
	},
	'rafamadriz/friendly-snippets',                -- Snippet collection
	'johnpapa/vscode-angular-snippets',            -- Angular snippets
	'dsznajder/vscode-es7-javascript-react-snippets', -- React snippets

	-- Autocompletion stuff
	'hrsh7th/nvim-cmp',  -- Autocompletion engine
	'hrsh7th/cmp-nvim-lsp', -- Autocompletion sources
	'hrsh7th/cmp-nvim-lua',
	'hrsh7th/cmp-nvim-lsp-signature-help',
	'hrsh7th/cmp-path',
	'hrsh7th/cmp-buffer',
	'saadparwaiz1/cmp_luasnip',

	'jose-elias-alvarez/typescript.nvim', -- Typescript support

	'simrat39/rust-tools.nvim',        -- Rust tools

	'github/copilot.vim',              -- AI coding assistant
})
