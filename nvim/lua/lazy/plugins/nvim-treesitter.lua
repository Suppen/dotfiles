-- Syntax highlighting

return {
	'nvim-treesitter/nvim-treesitter',
	build = ':TSUpdate',
	opts = {
		sync_install = false,
		auto_install = true,
		highlight = {
			enable = true,
			additional_vim_regex_highlighting = false,
		},
		ident = {
			enable = true
		},
		tsx = {
			enable = true
		},
		autopairs = {
			enable = true
		},
		autotag = {
			enable = true
		}
	}
}
