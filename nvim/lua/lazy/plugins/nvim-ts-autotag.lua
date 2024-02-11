-- Auto close HTML tags

return {
	'windwp/nvim-ts-autotag',
	depends = { 'nvim-treesitter' },
	ft = {
		'html',
		'javascript',
		'typescript',
		'javascriptreact',
		'typescriptreact',
		'typescript.tsx',
		'javascript.jsx',
		'xml',
		'markdown'
	},
}
