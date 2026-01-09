return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	opts = {
		formatters_by_ft = {
			typescript = { "prettier" },
			typescriptreact = { "prettier" },
			javascript = { "prettier" },
			javascriptreact = { "prettier" },
			json = { "prettier" },
			css = { "prettier" },
			html = { "prettier" },
			markdown = { "prettier" },
			lua = { "stylua" },
		},
		-- Default format options
		default_format_opts = {
			lsp_format = "fallback",
		},
		-- Format on save
		format_on_save = {
			timeout_ms = 500,
			lsp_format = "fallback",
		},
	},
}
