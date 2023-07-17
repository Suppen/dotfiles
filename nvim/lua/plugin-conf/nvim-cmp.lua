local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
	print "Could not require cmp"
	return
end

local luasnip_status_ok, luasnip = pcall(require, "luasnip.loaders.from_vscode")
if not luasnip_status_ok then
	print "Could not require luasnip.loaders.from_vscode"
else
	luasnip.lazy_load({
		paths = {
			'~/.local/share/nvim/plugged/friendly-snippets',
			'~/.local/share/nvim/plugged/vscode-angular-snippets',
			'~/.local/share/nvim/plugged/vscode-es7-javascript-react-snippets',
		}
	})
end

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
