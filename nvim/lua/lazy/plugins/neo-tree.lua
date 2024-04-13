-- File explorer

return {
	"nvim-neo-tree/neo-tree.nvim",
	lazy = true,
	keys = { "<leader>n" },
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	config = function()
		-- Disable netrw
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1

		-- Set up neo-tree itself
		require("neo-tree").setup({
			disable_netrw = true,
			auto_close = true,
			update_focused_file = {
				enable = true,
				update_cwd = true,
			},
			window = {
				width = 30,
				side = "left",
				auto_resize = true,
			},
		})

		-- Set up keymaps
		vim.api.nvim_set_keymap("n", "<leader>nt", ":Neotree filesystem toggle<CR>", { silent = true })
		vim.api.nvim_set_keymap("n", "<leader>ng", ":Neotree git_status toggle<CR>", { silent = true })
		vim.api.nvim_set_keymap("n", "<leader>nb", ":Neotree buffers toggle<CR>", { silent = true })
		vim.api.nvim_set_keymap("n", "<leader>nf", ":Neotree reveal<CR>", { silent = true })
	end,
}
