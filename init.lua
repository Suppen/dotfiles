-- Requires vim-plug: https://github.com/junegunn/vim-plug. Put plug.vim in
-- ~/.local/share/nvim/site/autoload/
-- After installing vim-plug and this init.lua, run :PlugInstall in nvim
vim.cmd([[
" Keep Plug commands between plug#begin() and plug#end().
call plug#begin()

Plug 'williamboman/mason.nvim'    " Package manager
Plug 'williamboman/mason-lspconfig.nvim'

Plug 'preservim/nerdtree'         " File browser

" Download and install a NerdFont too: https://github.com/ryanoasis/nerd-fonts/releases/tag/v2.1.0
" Konsole uses the font called Hack
Plug 'ryanoasis/vim-devicons'     " Fancy icons

Plug 'tpope/vim-surround'         " Surrond stuff with other stuff

Plug 'pangloss/vim-javascript'    " JavaScript support
Plug 'leafgarland/typescript-vim' " TypeScript syntax
Plug 'maxmellon/vim-jsx-pretty'   " JS and JSX syntax
Plug 'jparise/vim-graphql'        " GraphQL syntax

Plug 'rust-lang/rust.vim'         " Rust support

Plug 'neovimhaskell/haskell-vim'  " Haskell support

Plug 'airblade/vim-gitgutter'     " Git diff on lines edited
Plug 'tpope/vim-fugitive'         " Git support

Plug 'vim-airline/vim-airline'    " Better statusline

Plug 'tpope/vim-commentary'       " Comment/uncomment stuff

Plug 'tpope/vim-repeat'           " Repeat plugin commands

Plug 'neoclide/coc.nvim', {'branch': 'release'} " Loads of useful plugins

Plug 'puremourning/vimspector'    " Debugging
Plug 'mfussenegger/nvim-dap'      " Debug adapter protocol

Plug 'NLKNguyen/papercolor-theme' " Fancy color theme

" Requires fzf to be installed on the system to work
Plug 'junegunn/fzf'               " Set up fzf and fzf.vim
Plug 'junegunn/fzf.vim'

" All of your Plugins must be added before the following line
call plug#end()
]])

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

---------------
-- / Plugins --
---------------

-- Search all subdirectories of the root
vim.opt.path:append("**")
-- Remember the position in the file when closing it
if vim.fn.has("autocmd") then
  vim.cmd([[au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif]])
end

-- Disable arrow keys, for hard mode
vim.api.nvim_set_keymap("n", "<Up>", "", { noremap = true })
vim.api.nvim_set_keymap("n", "<Down>", "", { noremap = true })
vim.api.nvim_set_keymap("n", "<Left>", "", { noremap = true })
vim.api.nvim_set_keymap("n", "<Right>", "", { noremap = true })

-- Look and feel
vim.cmd("colorscheme PaperColor")
vim.opt.lazyredraw = true -- Do not redraw when executing macros
vim.opt.updatetime = 300 -- Update the cache on disk after this many milliseconds without activity
vim.opt.mouse = "a" -- Enable mouse
vim.opt.scrolloff = 5 -- Show a few lines above/below the cursor when scrolling to top/bottom

-- Wrap long lines and treat them as break lines
vim.opt.wrap = true
vim.api.nvim_set_keymap("", "j", "gj", {})
vim.api.nvim_set_keymap("", "k", "gk", {})

-- Line numbers and signs
vim.opt.number = true
vim.opt.numberwidth = 3
vim.opt.signcolumn = "yes"
vim.opt.relativenumber = true -- Show line numbers as relative to the current one
vim.opt.colorcolumn = "120"
vim.opt.textwidth = 120

-- Folding
vim.opt.foldmethod = "syntax"
vim.opt.foldlevel=99
-- Enable folding with z
vim.api.nvim_set_keymap("n", "z", "za", {})

-- Search options
vim.opt.ignorecase = true -- Ignore case when searching
vim.opt.smartcase = true -- Don't ignore case when search contains uppercase chars

-- Tab Options
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = false

-- Indentation
vim.opt.cindent = true
vim.opt.smartindent = true

-- Disable bells and whistles
vim.opt.errorbells = false
vim.opt.visualbell = true

-- Allow copy and paste from system clipboard
vim.opt.clipboard = "unnamed"

-- Delete empty space from the end of lines on every save
vim.cmd([[autocmd BufWritePre * :%s/\s\+$//e"]])

-- Set default encoding to utf-8
vim.opt.termencoding = "utf-8"

-- Turn off backup
vim.opt.backup = false
vim.opt.writebackup = true
vim.opt.swapfile = false

-- Give more space for displaying messages
vim.opt.cmdheight = 2

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

vim.cmd([[
function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
]])

-- Highlight the symbol and its references when holding the cursor
vim.cmd("autocmd CursorHold * silent call CocActionAsync('highlight')")

-- Autoformat on save
vim.g.rustfmt_autosave = 1

-- Use CTRL-S for selections ranges.
-- Requires 'textDocument/selectionRange' support of language server.
vim.api.nvim_set_keymap("n", "<C-s>", "<Plug>(coc-range-select)", { silent = true })
vim.api.nvim_set_keymap("x", "<C-s>", "<Plug>(coc-range-select)", { silent = true })

-- Leader key is SPACE
vim.api.nvim_set_var("mapleader", " ")

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
-- List open buffers
vim.api.nvim_set_keymap("n", "<leader>l", ":<C-u>Buffers<CR>", { silent = true, noremap = true})
-- List files
vim.api.nvim_set_keymap("n", "<leader>f", ":<C-u>Files<CR>", { silent = true, noremap = true})
-- Comment stuff with leader + /
vim.api.nvim_set_keymap("n", "<leader>/", ":Commentary<cr>", { silent = true, noremap = true})

-- NERDTree
-- Show hidden files
vim.cmd("let NERDTreeShowHidden=1")
-- Toggle NERDTree
vim.api.nvim_set_keymap("n", "<leader>nt", ":NERDTreeToggle<CR>", { silent = true, noremap = true })

-- Make fzf ignore some directories
vim.cmd("let $FZF_DEFAULT_COMMAND='find . \\( -name node_modules -o -name .git \\) -prune -o -print'")
