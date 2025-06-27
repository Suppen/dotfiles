-- Syntax highlighting

return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		build = ":TSUpdate",
		opts = {
			sync_install = false,
			auto_install = true,
			ensure_installed = {
				"typescript",
				"javascript",
				"tsx",
				"json",
				"html",
				"css",
				"scss",
				"lua",
				"rust",
				"toml",
			},
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},
			ident = {
				enable = true,
			},
			tsx = {
				enable = true,
			},
			autopairs = {
				enable = true,
			},
			autotag = {
				enable = true,
			},
		},
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("treesitter-context").setup()
		end,
	},
}
