-- Autocomplete engine

return {
	'hrsh7th/nvim-cmp',
	event = "InsertEnter",
	dependencies = {
		'L3MON4D3/LuaSnip',
		'rafamadriz/friendly-snippets', -- Snippets
		'hrsh7th/cmp-buffer',           -- Autocomplete from buffer
		'hrsh7th/cmp-nvim-lsp-signature-help', -- Show signature help
		'hrsh7th/cmp-nvim-lsp',         -- Autocomplete from LSP
		'hrsh7th/cmp-nvim-lua',         -- Autocomplete from Lua
		'hrsh7th/cmp-path',             -- Autocomplete from path
		'saadparwaiz1/cmp_luasnip',     -- Autocomplete from snippets
	},
	config = function()
		local datapath = vim.fn.stdpath('data')

		local luasnip = require('luasnip.loaders.from_vscode')
		luasnip.lazy_load({
			paths = {
				datapath .. '/lazy/friendly-snippets',
				datapath .. '/lazy/vscode-angular-snippets',
				datapath .. '/lazy/vscode-es7-javascript-react-snippets',
			}
		})

		local cmp = require('cmp')

		cmp.setup {
			mapping = cmp.mapping.preset.insert {
				['<C-b>'] = cmp.mapping.scroll_docs(-4),
				['<C-f>'] = cmp.mapping.scroll_docs(4),
				['<C-Space>'] = cmp.mapping.complete(),
				['<C-e>'] = cmp.mapping.abort(),
				['<CR>'] = cmp.mapping.confirm({ select = false })
			},
			snippet = {
				expand = function(args)
					require("luasnip").lsp_expand(args.body)
				end
			},
			window = {
				completion = cmp.config.window.bordered(),
				documentation = cmp.config.window.bordered(),
			},
			sources = cmp.config.sources({
				{ name = 'nvim_lsp' },
				{ name = 'nvim_lua' },
				{ name = 'nvim_lsp_signature_help' },
				{ name = 'path' },
				{ name = 'buffer' },
				{ name = 'luasnip' }
			}),
			formatting = {
				fields = { 'menu', 'abbr', 'kind' },
				format = function(entry, item)
					local menu_icon = {
						nvim_lsp = 'λ',
						luasnip = '⋗',
						buffer = 'Ω',
						path = '🖫',
					}
					item.menu = menu_icon[entry.source.name]
					return item
				end,
			},
		}

		--cmp.setup.cmdline({ '/', '?' }, {
		--mapping = cmp.mapping.preset.cmdline(),
		--sources = {
		--{ name = 'buffer' }
		--}
		--})

		--cmp.setup.cmdline(':', {
		--mapping = cmp.mapping.preset.cmdline(),
		--sources = cmp.config.sources({
		--{ name = 'path' }
		--}, {
		--{ name = 'cmdline' }
		--})
		--})
	end
}
