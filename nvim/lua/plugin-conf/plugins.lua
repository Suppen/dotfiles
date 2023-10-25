local status_ok, lazy = pcall(require, "lazy")
if not status_ok then
	print "Failed to load lazy.nvim"
	return
end

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

	'lukas-reineke/indent-blankline.nvim',                   -- Visualise line indents
	'nvim-tree/nvim-web-devicons',                           -- Fancy icons
	'nvim-tree/nvim-tree.lua',                               -- File browser
	{
		-- Syntax highlighting
		'nvim-treesitter/nvim-treesitter',
		build = ':TSUpdate'
	},
	'windwp/nvim-autopairs',                                 -- Automatically pair certain characters
	'windwp/nvim-ts-autotag',                                -- Automatically pair html (and html-ish) tags
	'tpope/vim-surround',                                    -- Surrond stuff with other stuff
	'folke/trouble.nvim',                                    -- Show errors in a floating window
	'airblade/vim-gitgutter',                                -- Git diff on lines edited
	'tpope/vim-fugitive',                                    -- Git support
	'nvim-lualine/lualine.nvim',                             -- Better statusline
	'preservim/nerdcommenter',                               -- Comment/uncomment stuff
	'tpope/vim-repeat',                                      -- Repeat plugin commands

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
