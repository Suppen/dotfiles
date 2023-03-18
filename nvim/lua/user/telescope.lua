local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
	print "Could not require telescope"
	return
end

telescope.setup { }

local builtin = require "telescope.builtin"

vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
