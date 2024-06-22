-- File explorer

return {
	"nvim-tree/nvim-tree.lua",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		-- Disable netrw
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1

		-- Setup nvim-tree
		local nvim_tree = require("nvim-tree")
		nvim_tree.setup({
			sort_by = "case_sensitive",
			renderer = {
				group_empty = true,
			},
			filters = {
				dotfiles = false,
			},
		})

		vim.keymap.set("n", "<leader>nt", ":NvimTreeToggle<CR>", { silent = true, desc = "Toggle NvimTree" })
		vim.keymap.set("n", "<leader>nf", ":NvimTreeFindFile<CR>", { silent = true, desc = "Find file in NvimTree" })
	end,
}
