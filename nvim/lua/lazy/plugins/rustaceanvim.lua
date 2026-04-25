-- Rust support

return {
	{
		"mrcjkb/rustaceanvim",
		version = "^8",
		lazy = false, -- This plugin is already lazy
	},
	{
		"saecki/crates.nvim",
		tag = "stable",
		event = { "BufRead Cargo.toml", "BufNewFile Cargo.toml" },
		config = function()
			require("crates").setup()
		end,
	},
}
