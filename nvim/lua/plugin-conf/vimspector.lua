vim.g.vimspector_sidebar_width = 85
vim.g.vimspector_bottombar_height = 15
vim.g.vimspector_terminal_maxwidth = 70

vim.api.nvim_set_keymap("n", "<F9>", ":call vimspector#Launch()<cr>", { silent = true, noremap = true })
vim.api.nvim_set_keymap("n", "<F5>", ":call vimspector#Continue()<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<F8>", ":call vimspector#Reset()<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<F11>", ":call vimspector#StepOver()<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<F12", ":call vimspector#StepOut()<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<F10>", "call vimspector#StepInto()<cr>", { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "Db", ":call vimspector#ToggleBreakpoint()<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "Dw", ":call vimspector#AddWatch()<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "De", ":call vimspector#Evaluate()<cr>", { noremap = true, silent = true })
