vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- [[ Install 'lazy.nvim' plugin manager ]]
require 'lazy-bootstrap'

-- [[ Configure Plugins]]
require 'lazy-plugins'

-- [[ Setting Options ]]
require 'options'

-- [[ Basic Keymaps ]]
require 'keymaps'

-- [[ Configure Telescope ]]
-- (fuzzy finder)
require 'telescope-setup'

-- [[ Configure Treesitter ]]
-- (syntax parser for highlighting)
require 'treesitter-setup'
