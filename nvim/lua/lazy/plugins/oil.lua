return {
	"stevearc/oil.nvim",
	opts = {
		default_file_explorer = false,
	},
	dependencies = { { "nvim-tree/nvim-web-devicons" } },
	-- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
	lazy = false,
}
