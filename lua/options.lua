-- [[ Setting options ]]
-- See ':help vim.o'

-- sets line number for current line and relative for all others
vim.wo.number = true
vim.wo.relativenumber = true

-- Sync clipboard between OS and Neovim
-- Remove this option if you want your OS clipboard to remain independent.
-- See ':help 'clipboard'
vim.o.clipboard = 'unnamedplus'

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true



