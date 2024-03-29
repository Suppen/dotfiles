-- Rust support

return {
	'mrcjkb/rustaceanvim',
	version = '^4',
	ft = { 'rust' },
	config = function()
		-- Format on save. RustFmt does not work for some reason
		vim.cmd [[autocmd BufWritePre *.rs lua vim.lsp.buf.format()]]
	end
}
