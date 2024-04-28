return {
	{
		"mfussenegger/nvim-dap",
		enabled = true,
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio",
		},
		lazy = true,
		-- stylua: ignore
		keys = {
			{ "<leader>db", mode = "n", function() require("dap").toggle_breakpoint() end, desc = "Toggle breakpoint" },
			{ "<leader>dc", mode = "n", function() require("dap").continue() end,          desc = "Continue" },
			{ "<leader>dx", mode = "n", function() require("dap").terminate() end,         desc = "Terminate" },
			{ "<leader>do", mode = "n", function() require("dap").step_over() end,         desc = "Step over" },
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

			dapui.setup()

			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end
		end,
	},
}
