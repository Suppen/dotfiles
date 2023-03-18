local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
	print "Could not require nvim-treesitter.configs"
	return
end

configs.setup {
	sync_install = false,
	auto_install = true,
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
	indent = {
		enable = true
	},
	tsx = {
		enable = true
	}
}
