-- Git in the sign column

return {
	"lewis6991/gitsigns.nvim",
	opts = {
		on_attach = function(bufnr)
			local gs = package.loaded["gitsigns"]

			local function map(mode, lhs, rhs, opts)
				opts = opts or {}
				opts.buffer = bufnr
				vim.keymap.set(mode, lhs, rhs, opts)
			end

			map("n", "<leader>hs", gs.stage_hunk, { desc = "[H]unk [S]tage" })
			map("n", "<leader>hr", gs.reset_hunk, { desc = "[H]unk [R]eset" })
			map("v", "<leader>hs", function()
				gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end, { desc = "[H]unk [S]tage" })
			map("v", "<leader>hr", function()
				gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end, { desc = "[H]unk [R]eset" })
			map("n", "<leader>hS", gs.stage_buffer) -- TODO: Add desc
			map("n", "<leader>hu", gs.undo_stage_hunk, { desc = "[H]unk [U]ndo" })
			map("n", "<leader>hS", gs.stage_buffer) -- TODO: Add
			map("n", "<leader>hp", gs.preview_hunk, { desc = "[H]unk [P]review" })
			map("n", "<leader>hb", function()
				gs.blame_line({ full = true })
			end, { desc = "[H]unk [B]lame" })
			map("n", "<leader>tb", gs.toggle_current_line_blame, { desc = "[T]oggle [B]lame for current line" })
			map("n", "<leader>hd", gs.diffthis) -- TODO: Add desc
			map("n", "<leader>hD", function()
				gs.diffthis("~")
			end) -- TODO: Add desc
			map("n", "<leader>td", gs.toggle_deleted, { desc = "[T]oggle [D]eleted" })
		end,
	},
}
