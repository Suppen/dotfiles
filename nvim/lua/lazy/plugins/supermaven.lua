-- AI Code completion

return {
	"supermaven-inc/supermaven-nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		require("supermaven-nvim").setup({
			disable_inline_completion = true,
		})
	end,
}
