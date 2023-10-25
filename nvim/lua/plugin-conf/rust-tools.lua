local status_ok, rust_tools = pcall(require, "rust-tools")
if not status_ok then
	print "Failed to load rust_tools"
	return
end

rust_tools.setup {
	inlay_hints = {
		auto = true,
		only_current_line = true,
	}
}

-- Format on save. RustFmt does not work for some reason
vim.cmd [[autocmd BufWritePre *.rs lua vim.lsp.buf.format()]]
