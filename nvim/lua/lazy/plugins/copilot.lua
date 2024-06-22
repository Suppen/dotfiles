-- AI code completion

return {
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		opts = {
			suggestion = { enabled = false },
			panel = { enabled = false },
		},
		lazy = true,
	},
	{
		"zbirenbaum/copilot-cmp",
		dependencies = {
			"zbirenbaum/copilot.lua",
		},
		lazy = true,
		config = true,
	},
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		branch = "canary",
		dependencies = {
			{ "zbirenbaum/copilot.lua" },
			{ "nvim-lua/plenary.nvim" },
		},
		cmd = "CopilotChat",
		opts = {
			debug = true,
		},
	},
}
