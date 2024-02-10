-- AI code assistant

return {
	'zbirenbaum/copilot.lua',
	event = 'InsertEnter',
	config = {
		suggestion = {
			auto_trigger = true,
			keymap = {
				accept = "<Tab>"
			}
		}
	}
}
