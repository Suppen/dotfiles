-- AI agent

return {
	"greggh/claude-code.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim", -- Required for git operations
	},
	keys = { "<leader>c" },
	config = function()
		require("claude-code").setup()

		vim.keymap.set("n", "<leader>cc", ":ClaudeCode<CR>", { silent = true, desc = "[C]laude [C]ode" })
	end,
}
