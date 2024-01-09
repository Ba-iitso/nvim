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

-- Commands only map after language server attaches to current buffer
vim.api.nvim_create_autocmd('LspAttach', {
    group = BaiitsoGroup,
    callback = function(ev)
	-- Buffer local mappings
	-- See ':help vim.lsp.*'
	local opts = { buffer = ev.buf }
	vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
	vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
	vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
	vim.keymap.set("n", "<leader>vd", function() vim.lsp.diagnostic.open_float() end, opts)
	vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
	vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
	vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
	vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
    end,
})

-- Diagnostics
vim.diagnostic.config({
    virtual_text = true,
    update_in_insert = true,
    float = {
	focusable = false,
	style = 'minimal',
	border = 'rounded',
	source = 'always',
	header = '',
	prefix = '',
    },
})
