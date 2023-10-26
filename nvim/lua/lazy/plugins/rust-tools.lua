-- Rust support

return {
	'simrat39/rust-tools.nvim',
	opts = {
		inlay_hints = {
			auto = true,
			only_current_line = true,
		}
	},
	config = function()
		-- Format on save. RustFmt does not work for some reason
		vim.cmd [[autocmd BufWritePre *.rs lua vim.lsp.buf.format()]]
	end
}
