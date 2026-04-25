-- Fancy colorscheme

return {
	"EdenEast/nightfox.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		-- The colors of the window picker are terrible. Override them, and do so dynamically within the nightfox
		-- schemes
		vim.api.nvim_create_autocmd("ColorScheme", {
			pattern = { "nightfox", "dayfox", "dawnfox", "duskfox", "nordfox", "terafox", "carbonfox" },
			callback = function(something)
				local palette = require("nightfox.palette").load(something.match)

				vim.api.nvim_set_hl(0, "WindowPickerStatusLineNC", {
					fg = palette.fg1,
					bg = palette.bg1,
				})

				vim.api.nvim_set_hl(0, "LspReferenceText", { link = "Visual" })
				vim.api.nvim_set_hl(0, "LspReferenceRead", { link = "Visual" })
				vim.api.nvim_set_hl(0, "LspReferenceWrite", { bold = true, link = "Visual" })
			end,
		})

		vim.cmd.colorscheme("nightfox")
	end,
}
