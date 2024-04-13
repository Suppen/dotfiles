-- Outline

return {
	"hedyhli/outline.nvim",
	enabled = false, -- Testing out neo-tree's `document_symbols` source
	lazy = true,
	cmd = { "Outline", "OutlineOpen" },
	keys = {
		{ "<leader>o", "<cmd>Outline<CR>", desc = "Toggle outline" },
	},
	opts = {},
}
