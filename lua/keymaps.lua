-- [[ Basic Keymaps ]]


-- center cursor on pg up/down
vim.keymap.set('n', '<C-u>', '<C-u>zz', { noremap = true} )
vim.keymap.set('n', '<C-d>', '<C-d>zz', { noremap = true} )

--highlight on yank
--See ':help vim.highlight.on_yank()'
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
	vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = '*',
})

-- Move highlighted text in visual mode
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '>-2<CR>gv=gv")
