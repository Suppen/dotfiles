-- Color highlighter

local filetypes = {
	"css",
	"scss",
	"sass",
	"less",
	"javascript",
	"javascriptreact",
	"typescript",
	"typescriptreact",
	"html",
	"vue",
	"json",
}

return {
	"NvChad/nvim-colorizer.lua",
	event = { "BufReadPre", "BufNewFile" },
	ft = filetypes,
	opts = {
		filetypes = filetypes,
		user_default_options = {
			css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
			css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
			-- Available modes for `mode`: foreground, background,  virtualtext
			mode = "background", -- Set the display mode.
			-- Available methods are false / true / "normal" / "lsp" / "both"
			-- True is same as normal

			-- parsers can contain values used in |user_default_options|
			sass = { enable = false, parsers = { "css" } }, -- Enable sass colors
			virtualtext = "■",
		},
		-- all the sub-options of filetypes apply to buftypes
		--buftypes = {},
	},
}
