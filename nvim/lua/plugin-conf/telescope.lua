local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
	print "Failed to load telescope"
	return
end

telescope.setup { }

telescope.load_extension('fzy_native')

local builtin = require "telescope.builtin"

vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
