-- Snippet engine

return {
	'L3MON4D3/LuaSnip',
	version = 'v2.*',
	build = 'make install_jsregexp',
	lazy = true,
	dependencies = {
		'rafamadriz/friendly-snippets',            -- Snippets
		'johnpapa/vscode-angular-snippets',        -- Angular snippets
		'dsznajder/vscode-es7-javascript-react-snippets', -- React snippets
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
	end
}
