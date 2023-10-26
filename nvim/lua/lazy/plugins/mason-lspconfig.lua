-- Mason LSP config
--
return {
	'williamboman/mason-lspconfig.nvim',
	opts = {
		ensure_installed = { "lua_ls", "tsserver", "eslint", "angularls" },
		automatic_installation = true
	}
}
