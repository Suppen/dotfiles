-- LSP stuff

--------------
-- Mappings --
--------------

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		-- Enable inlay hints
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		if client.server_capabilities.inlayHintProvider then
			vim.lsp.inlay_hint.enable(true, { buffer = ev.buf })
		end

		-- Buffer local mappings.
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		local opts = { noremap = true, silent = true, buffer = ev.buf }
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts, { desc = "Go to [D]eclaration" })
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts, { desc = "Go to [D]efinition" })
		vim.keymap.set("n", "gy", vim.lsp.buf.type_definition, opts, { desc = "Go to [T]ype [D]efinition" })
		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts, { desc = "Go to [I]mplementation" })
		--vim.keymap.set("n", "gr", vim.lsp.buf.references, opts) --Handled by telescope
		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts, { desc = "Show Hover" })
		vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
		vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
		vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
		vim.keymap.set("n", "<leader>wl", function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, opts)
		vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts, { desc = "Rename symbol" })
		vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts, { desc = "[C]ode [A]ction" })
		vim.keymap.set("n", "<leader>gf", function()
			vim.lsp.buf.format({
				async = true,
				filter = function(client)
					-- JS/TS formatting is handled by ESLint
					return client.name ~= "tsserver"
				end,
			})
		end, opts)

		-- Format on save
		if vim.b[ev.buf] == nil or vim.b[ev.buf].format_on_save_set == nil then
			-- Guard against setting the autocmd multiple times
			vim.b[ev.buf] = vim.b[ev.buf] or {}
			vim.b[ev.buf].format_on_save_set = true

			vim.api.nvim_create_autocmd("BufWritePre", {
				buffer = ev.buf,
				callback = function()
					vim.lsp.buf.format({ async = false })
				end,
			})
		end
	end,
})

return {
	-- Mason LSP manager
	{
		"williamboman/mason.nvim",
		opts = {
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		},
	},
	-- Mason LSP config
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = {
			"williamboman/mason.nvim",
		},
		opts = {
			ensure_installed = { "lua_ls", "tsserver", "eslint", "angularls", "rust_analyzer" },
			automatic_installation = true,
		},
	},
	-- None-ls
	{
		"nvimtools/none-ls.nvim",
		dependencies = {
			"nvimtools/none-ls-extras.nvim",
		},
		config = function()
			local null_ls = require("null-ls")

			null_ls.setup({
				sources = {
					-- Disabled due to being ridiculously slow. Using the eslint language server instead, and
					-- configuring it to also use prettier
					--require("none-ls.diagnostics.eslint_d"),
					--require("none-ls.code_actions.eslint_d"),
					--require("none-ls.formatting.eslint_d"),
					--null_ls.builtins.formatting.prettierd,

					null_ls.builtins.formatting.stylua,
				},
			})
		end,
	},
	-- LSP config
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"hrsh7th/cmp-nvim-lsp",
		},
		config = function()
			local lspconfig = require("lspconfig")

			--------------------------------
			-- Config of lspconfig itself --
			--------------------------------

			-- Configure the diagnostics handler to show in a floating window
			lspconfig.util.default_config = vim.tbl_extend("force", lspconfig.util.default_config, {
				handlers = {
					["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
						-- Use a floating window to display diagnostics
						virtual_text = true,
						signs = true,
						underline = true,
						update_in_insert = false,
						severity_sort = true,
						float = {
							border = "single", -- You can customize the border style, e.g., 'rounded', 'double', etc.
						},
					}),
				},
			})

			vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { noremap = true, silent = true })

			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			---------
			-- Lua --
			---------

			lspconfig.lua_ls.setup({
				capabilities = capabilities,
			})

			-----------
			-- JS/TS --
			-----------

			lspconfig.tsserver.setup({
				capabilities = capabilities,
			})

			lspconfig.eslint.setup({
				-- This setup somehow activates the command EslintFixAll
				capabilities = capabilities,
				on_attach = function(_, bufnr)
					vim.api.nvim_create_autocmd("BufWritePre", {
						buffer = bufnr,
						command = "EslintFixAll",
					})
				end,
			})

			lspconfig.angularls.setup({
				capabilities = capabilities,
			})

			----------
			-- HTML --
			----------

			lspconfig.html.setup({
				capabilities = capabilities,
			})

			---------
			-- CSS --
			---------

			lspconfig.cssls.setup({
				capabilities = capabilities,
			})

			----------
			-- Rust --
			----------

			-- Handled by rustaceanvim

			-------------
			-- Haskell --
			-------------

			lspconfig.hls.setup({
				capabilities = capabilities,
			})
		end,
	},
}
