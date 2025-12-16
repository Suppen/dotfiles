-- AI Code completion

return {
	"supermaven-inc/supermaven-nvim",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		disable_inline_completion = true,
	},
}
