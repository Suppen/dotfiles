-- LSP config

return {
	'neovim/nvim-lspconfig',
	config = function()
		local lspconfig = require('lspconfig')

		--------------------------------
		-- Config of lspconfig itself --
		--------------------------------

		-- Configure the diagnostics handler to show in a floating window
		lspconfig.util.default_config = vim.tbl_extend('force', lspconfig.util.default_config, {
			handlers = {
				['textDocument/publishDiagnostics'] = vim.lsp.with(
					vim.lsp.diagnostic.on_publish_diagnostics, {
						-- Use a floating window to display diagnostics
						virtual_text = true,
						signs = true,
						underline = true,
						update_in_insert = false,
						severity_sort = true,
						float = {
							border = 'single' -- You can customize the border style, e.g., 'rounded', 'double', etc.
						}
					}
				),
			},
		})

		vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, { noremap = true, silent = true })


		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		---------
		-- Lua --
		---------

		lspconfig.lua_ls.setup {
			capabilities = capabilities
		}

		-----------
		-- JS/TS --
		-----------

		-- Setting up the ts language server is handled by the typescript.lua file

		lspconfig.eslint.setup {
			-- This setup somehow activates the command EslintFixAll
			capabilities = capabilities,
			on_attach = function(_, bufnr)
				vim.api.nvim_create_autocmd("BufWritePre", {
					buffer = bufnr,
					command = "EslintFixAll",
				})
			end,
		}

		lspconfig.angularls.setup {
			capabilities = capabilities
		}

		----------
		-- Rust --
		----------

		-- Handled by rust-tools

		-------------
		-- Haskell --
		-------------

		lspconfig.hls.setup {
			capabilities = capabilities
		}

		--------------
		-- Mappings --
		--------------

		-- Use LspAttach autocommand to only map the following keys
		-- after the language server attaches to the current buffer
		vim.api.nvim_create_autocmd('LspAttach', {
			group = vim.api.nvim_create_augroup('UserLspConfig', {}),
			callback = function(ev)
				-- Enable completion triggered by <c-x><c-o>
				vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

				-- Buffer local mappings.
				-- See `:help vim.lsp.*` for documentation on any of the below functions
				local opts = { noremap = true, silent = true, buffer = ev.buf }
				--vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
				vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
				vim.keymap.set('n', 'gy', vim.lsp.buf.type_definition, opts)
				vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
				vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
				vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
				vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
				vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
				vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
				vim.keymap.set('n', '<leader>wl', function()
					print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
				end, opts)
				vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
				vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
				vim.keymap.set('n', '<leader>f', function()
					vim.lsp.buf.format {
						async = true,
						filter = function(client)
							-- JS/TS formatting is handled by ESLint
							return client.name ~= 'tsserver'
						end,
					}
				end, opts)
			end,
		})
	end
}
