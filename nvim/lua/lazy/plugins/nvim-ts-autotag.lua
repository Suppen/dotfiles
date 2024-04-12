-- Auto close HTML tags

return {
	"windwp/nvim-ts-autotag",
	dependencies = { "nvim-treesitter" },
	ft = {
		"html",
		"javascript",
		"typescript",
		"javascriptreact",
		"typescriptreact",
		"typescript.tsx",
		"javascript.jsx",
		"xml",
		"markdown",
	},
}
