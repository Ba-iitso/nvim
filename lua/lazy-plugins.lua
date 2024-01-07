require('lazy').setup({
    'tpope/vim-rhubarb',
    'tpope/vim-sleuth',
    'nvim-lua/plenary.nvim',
    'folke/zen-mode.nvim',
    {
        'tpope/vim-fugitive',
        keys = {
            { '<leader>gc', '<cmd>Git commit<cr>', desc = '[g]it [c]ommit' },
        }
    },
    
    {
        'folke/trouble.nvim',
        config = function()
	    require('trouble').setup({
	        icons = false,
	    })

            vim.keymap.set('n', '<leader>tt', function()
	        require('trouble').toggle() 
	    end)

            vim.keymap.set('n', '<leader>tn', function()
	        require('trouble').next({skip_groups = true, jump = true});
	    end)

            vim.keymap.set('n', '<leader>tt', function()
	        require('trouble').previous({skip_groups = true, jump = true}); 
	    end)

        end
    },

    {
        -- Color scheme
        'catppuccin/nvim',
        name = 'catppuccin',
        priority = 1000,
        opts = {
            flavour = 'mocha', -- latte, frappe, macchiato, mocha
            styles = { -- Handles the styles of general hi groups (see ':h highlight-args'):
                comments = { "italic"}, -- Change the style of comments
                conditionals = {},
                loops = {},
                functions = {},
                keywords = {},
                strings = {},
                variables = {},
                numbers = {},
                booleans = {},
                properties = {},
                types = {},
                operators = {},
            },
            integrations = {
                harpoon = true,
                mason = true,
                treesitter = true,
                gitsighns = true,
                indent_blankline = {
                    enabled = true,
                    scope_color = "lavender", -- catppuccin color (eg. 'lavender') Default: text
                    colored_indent_levels = false,
                },
                native_lsp = {
                    enabled = true,
                    virtual_text = {
                        errors = { "italic" },
                        hints = { "italic" },
                        warnings = { "italic" },
                        information = { "italic" },
                    },
                    underlines = {
                        errors = { "underline" },
                        hints = { "underline" },
                        warnings = { "underline" },
                        information = { "underline" },
                    },
                    inlay_hints = {
                        background = true,
                    },
                },
                telescope = {
                    enabled = true,
                    -- style = "nvchad"
                },
                which_key = true,

            },
        },
        config = function()
            vim.cmd('colorscheme catppuccin')
        end
    },


    {
        'neovim/nvim-lspconfig',
        dependencies = {
            { 'williamboman/mason.nvim', config = true },
            'williamboman/mason-lspconfig.nvim',
            
            --Useful status updates for LSP
            --NOTE: 'opts = {}' is the same as calling 'require('fidget').setup({})'
            { 'j-hui/fidget.nvim', opts = {} },
          
          'folke/neodev.nvim',
	},

        config = function()
            require('mason').setup()
            require('mason-lspconfig').setup({
                ensure_installed = {
                    'lua_ls',
                },

                handlers = {
                    function (server_name) -- default handler (optional)
                        require('lspconfig')[server_name].setup{}
                    end,
                }
            })
        end
    },

    {
        -- Add indentation guides even on blank lines
        'lukas-reineke/indent-blankline.nvim',
        -- see ':help ibl'
        main = 'ibl',
        opts = {
	    indent = { char = "|"},
	},
    },

    {
        -- Fuzzy Finder (files, lsp, etc)
        'nvim-telescope/telescope.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim',
            -- Fuzzy Finder Algorithm which requires local dependencies to be build.
            -- Only load if 'make' is available. Make sure you have the system
            -- requirements installed.
            {
            	'nvim-telescope/telescope-fzf-native.nvim',
    	        -- NOTE: If you are having trouble with this installation,
    	        --	 refer to the README for telescope-fzf-native for more instructions.
    	        build = 'make',
    	        cond = function()
    	            return vim.fn.executable 'make' == 1
    		end,
    	    },
    	},
    },

    {
        -- Highlight, edit, and navigate code
        'nvim-treesitter/nvim-treesitter',
        dependencies = {
    	    'nvim-treesitter/nvim-treesitter-textobjects'
        },
        build = ':TSUpdate',
    },
    
    {
        'folke/which-key.nvim',
        event = 'VeryLazy',
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
        opts = { -- check git for opts 
            icons = {
                seperator = "-",
            },
        }
    },

    {
        'ThePrimeagen/harpoon',
        branch = 'harpoon2',
        dependencies = { 'nvim-lua/plenary.nvim' },
        opts = {},
        config = function()
            local harpoon = require("harpoon")

            harpoon:setup()

	    vim.keymap.set("n", "<leader>a", function() harpoon:list():append() end, {desc = '[a]ppend to harpoon list'})
	    vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

	    vim.keymap.set("n", "<C-j>", function() harpoon:list():select(1) end)
	    vim.keymap.set("n", "<C-k>", function() harpoon:list():select(2) end)
	    vim.keymap.set("n", "<C-l>", function() harpoon:list():select(3) end)
	    vim.keymap.set("n", "<C-;>", function() harpoon:list():select(4) end)

            -- Toggle previous & next buffers stored within Harpoon list
	    vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end)
	    vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end)
        end
    },


}, {})