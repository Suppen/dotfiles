local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
	print "Could not require nvim-tree"
	return
end

nvim_tree.setup({
	sort_by = "case_sensitive",
	renderer = {
		group_empty = true,
	},
	filters = {
		dotfiles = false,
	},
})

vim.api.nvim_set_keymap("n", "<leader>nt", ":NvimTreeToggle<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<leader>nf", ":NvimTreeFindFile<CR>", { silent = true })
