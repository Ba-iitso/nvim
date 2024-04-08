require('lazy').setup({
    'tpope/vim-rhubarb',
    'tpope/vim-sleuth',
    'nvim-lua/plenary.nvim',
    'folke/zen-mode.nvim',

    {
        'tpope/vim-fugitive',
        keys = {
            { '<leader>Gc', '<cmd>Git commit<cr>', desc = '[G]it [c]ommit' },
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

            vim.keymap.set('n', ']d', function()
	        require('trouble').next({skip_groups = true, jump = true});
	    end)

            vim.keymap.set('n', '[d', function()
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
            { 'williamboman/mason.nvim', config = true},
            'williamboman/mason-lspconfig.nvim',

            --useful status updates for LSP
            --NOTE: 'opts = {}' is the same as calling 'require('fidget').setup'
            { 'j-hui/fidget.nvim', opts ={} },

            'folke/neodev.nvim',
        },

        config = function()
            require('mason').setup()
            require('mason-lspconfig').setup({
                ensure_installed = {
                    'lua_ls',
                    'pyright',
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
        -- Autocompletion
        'hrsh7th/nvim-cmp',
        dependencies = {
            -- Snippet engine & its associated nvim-cmp source
            'L3MON4D3/LuaSnip',
            'saadparwaiz1/cmp_luasnip',

            -- Adds LSP completion capabilities
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-path',

            'hrsh7th/cmp-buffer',
        },

        config = function()
            
            local cmp = require'cmp'

            cmp.setup({
                snippet = {
                    -- REQUIRED - you must specify a snippet engine
                    expand = function(args)
                        --vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
                         require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
                        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
                    end,
                },
                window = {
                    -- completion = cmp.config.window.bordered(),
                    -- documentation = cmp.config.window.bordered(),
                },
                mapping = cmp.mapping.preset.insert({
                    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-e>'] = cmp.mapping.abort(),
                    ['<CR>'] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                }),
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                    --{ name = 'vsnip' }, -- For vsnip users.
                    { name = 'luasnip' }, -- For luasnip users.
                    -- { name = 'ultisnips' }, -- For ultisnips users.
                    -- { name = 'snippy' }, -- For snippy users.
                }, {
                    { name = 'buffer' },
                })
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
        'mbbill/undotree',
        keys = {
            { '<leader>u', vim.cmd.UndotreeToggle, desc = '[u]ndotree toggle' },
        }
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
    
    {--Collection of various small independant plugins/modules
        'echasnovski/mini.nvim',
        config = function()
            --Better Around/Inside textobjects
            --
            --Examples:
            -- - va)  - [V]isually select [A]round [)]parenthen
            -- - yinq - [Y]ank [I]nside [N]ext [']quote
            -- - ci'  - [C]hange [I]nside [']quote
            require('mini.ai').setup { n_lines = 500 }

            -- Add/delete/replace surroundings (brackets, quotes, etc)
            --
            -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
            -- - sd'   - [S]urround [D]elete [']quotes
            -- - sr)'  - [S]urround [R]eplace [)] [']
            require('mini.surround').setup()

            -- Simple easy statusline
            local statusline = require 'mini.statusline'
            statusline.setup()

            -- You can configure sections in the statusline by overriding their
            -- default behavior. For example, here we disable the section for
            -- cursor information because line numbers are already enabled
            ---@diagnostic disable-next-line: duplicate-set-field
            statusline.section_location = function()
                return ''
            end

            -- For commenting out blocks of text
            -- 
            -- - gc  - toggle comment(follow with text obj, eg: gcip to toggle "[I]n [P]aragraph")
            -- - gcc - toggle comment on current line
            -- can add functions to modify behavior before or after commenting
            require('mini.comment').setup()

            -- Automatically creates the left paren/quote/brace when typing the right one. 
            require('mini.pairs').setup()

            -- ... and there is more!
            -- Check out: https://github.com/echasnovsky/mini.nvim
        end,
    },

}, {})
