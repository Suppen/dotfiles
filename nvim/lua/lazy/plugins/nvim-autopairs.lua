-- Automatically pair certain characters

return {
	"windwp/nvim-autopairs",
	event = "InsertEnter",
	config = function()
		require("nvim-autopairs").setup({
			check_ts = true,
			ts_config = {
				lua = { "string" },
				javascript = { "template_string" },
				java = false,
			},
			fast_wrap = {
				map = "<M-e>",
				chars = { "{", "[", "(", '"', "'" },
				pattern = [=[[%'%"%>%]%)%}%,]]=],
				end_key = "$",
				keys = "qwertyuiopzxcvbnmasdfghjkl",
				check_comma = true,
				highlight = "Search",
				highlight_grey = "Comment",
			},
		})
	end,
}
