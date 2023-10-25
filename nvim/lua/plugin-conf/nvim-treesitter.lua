local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
	print "Failed to load nvim-treesitter.configs"
	return
end

configs.setup {
	sync_install = false,
	auto_install = true,
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
	ident = {
		enable = true
	},
	tsx = {
		enable = true
	},
	autopairs = {
		enable = true
	},
	autotag = {
		enable = true
	},
}
