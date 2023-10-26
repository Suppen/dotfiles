-- Automatically pair certain characters

return {
	'windwp/nvim-autopairs',
	event = 'InsertEnter',
	dependencies = {
		'hrsh7th/nvim-cmp'
	},
	config = function()
		local autopairs = require('nvim-autopairs')
		local cmp = require('cmp')
		local cmp_autopairs = require('nvim-autopairs.completion.cmp')

		autopairs.setup {
			check_ts = true,
			ts_config = {
				lua = { 'string' }, -- it will not add a pair on that treesitter node
				javascript = { 'template_string' },
				java = false, -- don't check treesitter on java
			},
			fast_wrap = {
				map = '<M-e>',
				chars = { '{', '[', '(', '"', "'" },
				pattern = [=[[%'%"%>%]%)%}%,]]=],
				end_key = '$',
				keys = 'qwertyuiopzxcvbnmasdfghjkl',
				check_comma = true,
				highlight = 'Search',
				highlight_grey = 'Comment'
			},
		}

		cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
	end
}
