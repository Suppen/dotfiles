-- Fuzzy search

return {
	'nvim-telescope/telescope.nvim',
	tag = '0.1.4',
	dependencies = {
		'nvim-lua/plenary.nvim',
		'nvim-telescope/telescope-fzy-native.nvim',
	},
	config = function()
		local telescope = require('telescope')
		telescope.load_extension('fzy_native')

		local builtin = require "telescope.builtin"

		vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
		vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
		vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
	end
}
