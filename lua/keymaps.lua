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
	vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition(), opts)
	vim.keymap.set("n", "gd", vim.lsp.buf.definition(), opts)
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration(), opts)
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation(), opts)
	vim.keymap.set("n", "gr", vim.lsp.buf.references(), opts)
	vim.keymap.set("n", "K", vim.lsp.buf.hover(), opts)
	vim.keymap.set("n", "<leader>vd", vim.lsp.diagnostic.open_float())
	vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol(), opts)
	vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action(), opts)
	vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename(), opts)
	vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help(), opts)
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

-- Execute current file if executable for linux
vim.keymap.set("n", "<leader>f.", function()
  local line = vim.api.nvim_buf_get_lines(0, 0, -1, false)[0]
  if not string.find(line, "^#!") then
    return
  else
    local file = vim.fn.expand("%") -- Get the current file name
    local escaped_file = vim.fn.shellescape(file)
    vim.cmd("!chmod +x " .. escaped_file)
    vim.cmd("vsplit") -- Split the window vertically
    vim.cmd("terminal " .. escaped_file) 
    vim.api.nvim_feedkeys("i", "n", false)
  end
end, { desc = "Execute current file in terminal" })
