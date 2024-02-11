-- AI code assistant

return {
	'zbirenbaum/copilot.lua',
	enabled = false,
	event = 'InsertEnter',
	opts = {
		panel = {
			enabled = false
		},
		suggestion = {
			debounce = 300,
			auto_trigger = true,
			keymap = {
				accept = "<M-CR>"
			}
		}
	}
}
