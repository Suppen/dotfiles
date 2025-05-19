-- Leader key is SPACE
vim.g.mapleader = " "

-- Search all subdirectories of the root
vim.opt.path:append("**")

-- Remember the position in the file when closing it
vim.api.nvim_create_autocmd("BufReadPost", {
	pattern = "*",
	callback = function()
		local last_pos = vim.fn.line("'\"")
		if last_pos > 1 and last_pos <= vim.fn.line("$") then
			vim.cmd("normal! g'\"")
		end
	end,
})

-- -- Disable arrow keys, for hard mode
vim.keymap.set({ "n", "i" }, "<Up>", "", { noremap = true })
vim.keymap.set({ "n", "i" }, "<Down>", "", { noremap = true })
vim.keymap.set({ "n", "i" }, "<Left>", "", { noremap = true })
vim.keymap.set({ "n", "i" }, "<Right>", "", { noremap = true })

-- Look and feel
vim.opt.lazyredraw = true -- Do not redraw when executing macros
vim.opt.updatetime = 300  -- Update the cache on disk after this many milliseconds without activity
vim.opt.mouse = "a"       -- Enable mouse
vim.opt.scrolloff = 5     -- Show a few lines above/below the cursor when scrolling to top/bottom

-- Wrap long lines
vim.opt.wrap = true

-- Line numbers and signs
vim.opt.number = true
vim.opt.numberwidth = 3
vim.opt.signcolumn = "yes"
vim.opt.relativenumber = true -- Show line numbers as relative to the current one
vim.opt.colorcolumn = "120"
vim.opt.textwidth = 120

-- Folding
vim.opt.foldmethod = "syntax"
vim.opt.foldlevel = 99

-- Search options
vim.opt.ignorecase = true -- Ignore case when searching
vim.opt.smartcase = true  -- Don't ignore case when search contains uppercase chars

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
vim.api.nvim_create_autocmd("BufWritePre", {
	callback = function()
		vim.cmd([[%s/\s\+$//e]])
	end,
})

-- Turn off backup
vim.opt.backup = false
vim.opt.writebackup = true
vim.opt.swapfile = false

-- Give more space for displaying messages
vim.opt.cmdheight = 2

-- Treesitter folding
vim.wo.foldmethod = "expr"
vim.wo.foldexpr = "nvim_treesitter#foldexpr()"

-- Load plugins
require("lazy.lazy")
