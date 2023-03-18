-- disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Leader key is SPACE
vim.api.nvim_set_var("mapleader", " ")

require "user.plugins"
require "user.coc"
require "user.nvim-tree"
require "user.nvim-treesitter"
require "user.indent-blankline"
require "user.telescope"
require "user.lualine"
require "user.hop"

-- Search all subdirectories of the root
vim.opt.path:append("**")
-- Remember the position in the file when closing it
if vim.fn.has("autocmd") then
	vim.cmd [[au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif]]
end

-- Disable arrow keys, for hard mode
vim.api.nvim_set_keymap("n", "<Up>", "", { noremap = true })
vim.api.nvim_set_keymap("n", "<Down>", "", { noremap = true })
vim.api.nvim_set_keymap("n", "<Left>", "", { noremap = true })
vim.api.nvim_set_keymap("n", "<Right>", "", { noremap = true })

-- Look and feel
vim.cmd [[colorscheme nightfox]]
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
vim.cmd [[autocmd BufWritePre * :%s/\s\+$//e"]]

-- Set default encoding to utf-8
vim.opt.termencoding = "utf-8"

-- Turn off backup
vim.opt.backup = false
vim.opt.writebackup = true
vim.opt.swapfile = false

-- Give more space for displaying messages
vim.opt.cmdheight = 2

-- Autoformat on save
vim.g.rustfmt_autosave = 1