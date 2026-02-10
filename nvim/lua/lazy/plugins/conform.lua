return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	init = function()
		vim.api.nvim_create_autocmd("FileType", {
			pattern = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
			once = true,
			callback = function()
				local registry = require("mason-registry")
				local ok, pkg = pcall(registry.get_package, "prettierd")
				if ok and not pkg:is_installed() then
					pkg:install()
				end
			end,
		})
	end,
	opts = {
		formatters_by_ft = {
			typescript = { "prettierd" },
			typescriptreact = { "prettierd" },
			javascript = { "prettierd" },
			javascriptreact = { "prettierd" },
			json = { "prettierd" },
			css = { "prettierd" },
			html = { "prettierd" },
			markdown = { "prettierd" },
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
