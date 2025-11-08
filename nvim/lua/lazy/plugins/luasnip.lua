-- Snippet engine

return {
	"L3MON4D3/LuaSnip",
	version = "v2.*",
	build = "make install_jsregexp",
	lazy = true,
	dependencies = {
		"saadparwaiz1/cmp_luasnip", -- Autocomplete from snippets
		"rafamadriz/friendly-snippets", -- Snippets
		"dsznajder/vscode-es7-javascript-react-snippets", -- React snippets
	},
	config = function()
		local datapath = vim.fn.stdpath("data")

		local luasnip = require("luasnip.loaders.from_vscode")
		luasnip.lazy_load({
			paths = {
				datapath .. "/lazy/friendly-snippets",
				datapath .. "/lazy/vscode-es7-javascript-react-snippets",
			},
		})
	end,
}
