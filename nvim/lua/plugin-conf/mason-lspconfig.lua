local status_ok, masonlsp = pcall(require, "mason-lspconfig")
if not status_ok then
	print "Could not require mason-lspconfig"
	return
end

masonlsp.setup {
	ensure_installed = { "lua_ls", "tsserver", "eslint", "angularls" },
	automatic_installation = true,
}
