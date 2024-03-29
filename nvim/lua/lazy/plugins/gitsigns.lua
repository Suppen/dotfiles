-- Git in the sign column

return {
	"lewis6991/gitsigns.nvim",
	config = {
		on_attach = function(bufnr)
			local gs = package.loaded["gitsigns"]

			local function map(mode, lhs, rhs, opts)
				opts = opts or {}
				opts.buffer = bufnr
				vim.keymap.set(mode, lhs, rhs, opts)
			end

			map('n', '<leader>hs', gs.stage_hunk)
			map('n', '<leader>hr', gs.reset_hunk)
			map('v', '<leader>hs', function() gs.stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end)
			map('v', '<leader>hr', function() gs.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end)
			map('n', '<leader>hS', gs.stage_buffer)
			map('n', '<leader>hu', gs.undo_stage_hunk)
			map('n', '<leader>hR', gs.reset_buffer)
			map('n', '<leader>hp', gs.preview_hunk)
			map('n', '<leader>hb', function() gs.blame_line { full = true } end)
			map('n', '<leader>tb', gs.toggle_current_line_blame)
			map('n', '<leader>hd', gs.diffthis)
			map('n', '<leader>hD', function() gs.diffthis('~') end)
			map('n', '<leader>td', gs.toggle_deleted)
		end
	}
}
