-- AI code completion

local enabled = false

return {
	{
		"zbirenbaum/copilot.lua",
		enabled = enabled,
		cmd = "Copilot",
		opts = {
			suggestion = { enabled = false },
			panel = { enabled = false },
		},
		lazy = true,
	},
	{
		"zbirenbaum/copilot-cmp",
		enabled = enabled,
		dependencies = {
			"zbirenbaum/copilot.lua",
		},
		lazy = true,
		config = true,
	},
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		enabled = enabled,
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
