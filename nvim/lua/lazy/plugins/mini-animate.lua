-- Animations of cursor movement and window operations

vim.api.nvim_create_user_command("Animate", function()
	require("lazy").load({ plugins = { "mini.animate" } })
end, {})

return {
	"echasnovski/mini.animate",
	lazy = true,
	command = "Animate",
	opts = {},
}
