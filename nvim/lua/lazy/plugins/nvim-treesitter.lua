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
				"dockerfile",
				"gitignore",
				"markdown",
			},
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},
			indent = {
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
