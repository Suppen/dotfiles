local status_ok, hop = pcall(require, "hop")
if not status_ok then
	print "Could not require hop"
	return
end

hop.setup {
	multi_windows = true
}

vim.api.nvim_set_keymap("n", "<leader>hw", ":HopWord<CR>", { noremap = true, silent = true })
