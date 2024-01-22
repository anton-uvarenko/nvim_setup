local set = vim.opt

-- tab size
local tabSize = 4
set.tabstop = tabSize
set.softtabstop = tabSize
set.shiftwidth = tabSize

-- line wrapping
set.wrap = false

-- Make line numbers default
vim.wo.number = true

-- Sync clipboard between OS and Neovim.
vim.o.clipboard = 'unnamedplus'

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

vim.o.termguicolors = true

