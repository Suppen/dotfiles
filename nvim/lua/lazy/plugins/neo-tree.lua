-- File explorer

return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			"nvim-tree/nvim-web-devicons",
		},
		keys = { "<leader>n" },
		config = function()
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
					mappings = {
						["s"] = "vsplit_with_window_picker",
						["S"] = "split_with_window_picker",
						["<cr>"] = "open_with_window_picker",
					},
				},
				sources = {
					"filesystem",
					"git_status",
					"buffers",
					"document_symbols",
				},
				filesystem = {
					use_libuv_file_watcher = true,
				},
			})

			-- Set up keymaps
			vim.keymap.set(
				"n",
				"<leader>nt",
				":Neotree filesystem toggle<CR>",
				{ silent = true, desc = "Toggle Neotree filesystem" }
			)
			vim.keymap.set(
				"n",
				"<leader>ng",
				":Neotree git_status toggle<CR>",
				{ silent = true, desc = "Toggle Neotree git status" }
			)
			vim.keymap.set(
				"n",
				"<leader>nb",
				":Neotree buffers toggle<CR>",
				{ silent = true, desc = "Toggle Neotree buffers" }
			)
			vim.keymap.set(
				"n",
				"<leader>no",
				":Neotree document_symbols toggle<CR>",
				{ silent = true, desc = "Toggle Neotree symbol outline" }
			)
			vim.keymap.set("n", "<leader>nf", ":Neotree reveal<CR>", { silent = true, desc = "Reveal file in Neotree" })
		end,
	},
	{
		"antosha417/nvim-lsp-file-operations",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-neo-tree/neo-tree.nvim", -- makes sure that this loads after Neo-tree.
		},
		config = function()
			require("lsp-file-operations").setup()
		end,
	},
	{
		"s1n7ax/nvim-window-picker",
		version = "2.*",
		config = function()
			-- NOTE For color of the picker bar, see the config of the nightfox plugin

			require("window-picker").setup({
				filter_rules = {
					include_current_win = false,
					autoselect_one = true,
					-- filter using buffer options
					bo = {
						-- if the file type is one of following, the window will be ignored
						filetype = { "neo-tree", "neo-tree-popup", "notify" },
						-- if the buffer type is one of following, the window will be ignored
						buftype = { "terminal", "quickfix" },
					},
				},
			})
		end,
	},
}
