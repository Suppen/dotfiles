local status_ok, autopairs = pcall(require, "nvim-autopairs")
if not status_ok then
	print "Could not require nvim-autopairs"
	return
end

autopairs.setup {
	check_ts = true,
	ts_config = {
		lua = {'string'},-- it will not add a pair on that treesitter node
		javascript = {'template_string'},
		java = false,-- don't check treesitter on java
	},
	fast_wrap = {
	  map = '<M-e>',
	  chars = { '{', '[', '(', '"', "'" },
	  pattern = [=[[%'%"%>%]%)%}%,]]=],
	  end_key = '$',
	  keys = 'qwertyuiopzxcvbnmasdfghjkl',
	  check_comma = true,
	  highlight = 'Search',
	  highlight_grey='Comment'
	},
}

local cmp_autopairs = require "nvim-autopairs.completion.cmp"
local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
	return
end
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
