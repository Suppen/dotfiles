-- CoC extensions
vim.g.coc_global_extensions = {
	"coc-pairs",
	"coc-tsserver",
	"coc-json",
	"coc-css",
	"coc-html",
	"coc-rust-analyzer"
}

-- Add CoC ESLint if ESLint is installed
if vim.fn.isdirectory("./node_modules") and vim.fn.isdirectory("./node_modules/eslint") then
  table.insert(vim.g.coc_global_extensions, "coc-eslint")
end

-- Add CoC Prettier if prettier is installed
if vim.fn.isdirectory("./node_modules") and vim.fn.isdirectory("./node_modules/prettier") then
  table.insert(vim.g.coc_global_extensions, "coc-prettier")
end

-- GoTo code navigation.
vim.api.nvim_set_keymap("n", "gd", "<Plug>(coc-definition)", { silent = true })
vim.api.nvim_set_keymap("n", "gy", "<Plug>(coc-type-definition)", { silent = true })
vim.api.nvim_set_keymap("n", "gi", "<Plug>(coc-implementation)", { silent = true })
vim.api.nvim_set_keymap("n", "gr", "<Plug>(coc-references)", { silent = true })

-- Use K to show documentation in preview window.
vim.api.nvim_set_keymap("n", "K", ":call ShowDocumentation()<CR>", { noremap = true, silent = true })
vim.cmd([[
function! ShowDocumentation()
	if CocAction('hasProvider', 'hover')
		call CocActionAsync('doHover')
	else
		call feedKeys('K', 'in')
	endif
endfunction
]])

vim.cmd([[
function! CheckBackspace() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~# '\s'
endfunction
]])

-- Use tab for trigger completion with characters ahead and navigate.
-- NOTE: There's always complete item selected by default, you may want to enable
-- no select by `"suggest.noselect": true` in your configuration file.
-- NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
-- other plugin before putting this into your config.
vim.cmd([[
inoremap <silent><expr> <TAB>
    \ coc#pum#visible() ? coc#pum#next(1) :
    \ CheckBackspace() ? "\<Tab>" :
    \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
]])

-- Make <CR> to accept selected completion item or notify coc.nvim to format
-- <C-g>u breaks current undo, please make your own choice.
vim.cmd([[
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
	\: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
]])

-- Use CTRL-S for selections ranges.
-- Requires 'textDocument/selectionRange' support of language server.
vim.api.nvim_set_keymap("n", "<C-s>", "<Plug>(coc-range-select)", { silent = true })
vim.api.nvim_set_keymap("x", "<C-s>", "<Plug>(coc-range-select)", { silent = true })

-- Symbol renaming.
vim.api.nvim_set_keymap("n", "<leader>rn", "<Plug>(coc-rename)", { silent = true, noremap = true})
-- Quick access to CocAction
vim.api.nvim_set_keymap("n", "<leader>ac", "<Plug>(coc-codeaction)", { silent = true, noremap = true})
-- Apply codelens action to current line
vim.api.nvim_set_keymap("n", "<leader>cl", "<Plug>(coc-codelens-action)", { silent = true, noremap = true})
-- Quick access to CocCommand
vim.api.nvim_set_keymap("n", "<leader>c", ":<C-u>CocList commands<CR>", { silent = true, noremap = true})
-- Apply AutoFix to problem on the current line.
vim.api.nvim_set_keymap("n", "<leader>qf", "<Plug>(coc-fix-current)", { silent = true, noremap = true})
-- Show outline of current file
vim.api.nvim_set_keymap("n", "<leader>o", ":<C-u>CocList outline<CR>", { silent = true, noremap = true})

-- Highlight the symbol and its references when holding the cursor
vim.cmd [[autocmd CursorHold * silent call CocActionAsync('highlight')]]
