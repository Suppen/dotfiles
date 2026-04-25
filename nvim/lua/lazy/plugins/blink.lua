-- Autocomplete engine

return {
	"saghen/blink.cmp",
	version = "1.*",
	dependencies = {
		"saghen/blink.compat", -- wraps nvim-cmp sources (supermaven)
	},
	opts = {
		keymap = {
			preset = "default",
			["<C-n>"] = { "show", "select_next", "fallback" },
			["<C-p>"] = { "show", "select_prev", "fallback" },
			["<C-b>"] = { "scroll_documentation_up", "fallback" },
			["<C-f>"] = { "scroll_documentation_down", "fallback" },
			["<C-Space>"] = { "show", "fallback" },
			["<C-e>"] = { "cancel", "fallback" },
			["<CR>"] = { "accept", "fallback" },
		},
		completion = {
			list = {
				selection = {
					preselect = false, -- <CR> only confirms explicitly selected items
				},
			},
			documentation = { window = { border = "rounded" } },
			menu = { border = "rounded" },
		},
		sources = {
			default = { "supermaven", "lsp", "path", "buffer" },
			providers = {
				supermaven = {
					name = "supermaven",
					module = "blink.compat.source",
					score_offset = 100,
				},
			},
		},
		signature = { enabled = true }, -- replaces cmp-nvim-lsp-signature-help
	},
}
