local Plug = vim.fn["plug#"]
vim.call("plug#begin", "~/.config/nvim/plugged")
Plug("nvim-lua/popup.nvim")                         -- An implementation of the Popup API from vim in Neovim
Plug("nvim-lua/plenary.nvim")                       -- Useful lua functions used ny lots of plugins
Plug("EdenEast/nightfox.nvim")                      -- dark theme
Plug("kyazdani42/nvim-web-devicons")                -- icons
Plug("feline-nvim/feline.nvim")                     -- bottom bar
Plug("lewis6991/gitsigns.nvim")                     -- git signs on the bar and on the left
Plug("tanvirtin/vgit.nvim")                         -- git plugin
Plug("nvim-lua/plenary.nvim")                       -- library, don't delete
Plug("williamboman/mason.nvim")                     -- lsp and dap
Plug("williamboman/mason-lspconfig.nvim")           -- lsp to mason bridge
Plug("neovim/nvim-lspconfig")                       -- nvim lsp
Plug("jose-elias-alvarez/null-ls.nvim")             -- enables formatters
Plug("jayp0521/mason-null-ls.nvim")                 -- mason to formatter
Plug("mfussenegger/nvim-dap")                       -- debugging capabilities
Plug("rcarriga/nvim-dap-ui")                        -- debug ui
Plug("theHamsta/nvim-dap-virtual-text")             -- more debug ui
Plug("jayp0521/mason-nvim-dap.nvim")                -- debug mason bridge
Plug("nvim-treesitter/nvim-treesitter", 
{ ["do"] = vim.fn[":TSUpdate"] })                   -- syntax colors
Plug("hrsh7th/nvim-cmp")                            -- completions
Plug("hrsh7th/cmp-nvim-lsp")                        -- lsp integration with completions
--Plug("hrsh7th/cmp-buffer")                          -- buffer completion
Plug("hrsh7th/cmp-path")                            -- path completion
Plug("hrsh7th/cmp-cmdline")                         -- command completion
--Plug("f3fora/cmp-spell")                            -- spelling completion
Plug("saadparwaiz1/cmp_luasnip")                    -- snip completion
Plug("L3MON4D3/LuaSnip")                            -- snippet plugin
Plug("kyazdani42/nvim-tree.lua")                    -- file viewer on the right
Plug("windwp/nvim-autopairs")                       -- autopairs
Plug("romgrk/barbar.nvim")                          -- bar on the top
Plug("numToStr/Comment.nvim")                       -- fast comments
Plug("lukas-reineke/indent-blankline.nvim")         -- indicators for indentation (needs config)
Plug("lewis6991/impatient.nvim")                    -- speedup startup
Plug("nvim-telescope/telescope.nvim")               -- file/text search
Plug("ahmedkhalf/project.nvim")                     -- project management -> switch projects
Plug("goolord/alpha-nvim")                          -- dashboard
Plug("lervag/vimtex")                               -- latex plugin
Plug("weilbith/nvim-code-action-menu")              -- code action menu
Plug("rafamadriz/friendly-snippets")                -- some provided snippets
Plug("p00f/nvim-ts-rainbow")                        -- colors brackets
Plug("nvim-telescope/telescope-ui-select.nvim")     -- telescope ui
Plug("nvim-telescope/telescope-file-browser.nvim")  -- telescope file browser
Plug("nvim-telescope/telescope-fzy-native.nvim")    -- telescope fuzzy search
Plug 'folke/trouble.nvim'                           -- provides warning/error explanation tab
--Plug("folke/twilight.nvim") --twilight dims code not being edited right now ? useless ?
--Plug("lambdalisue/fern.vim") -- likely not needed?
--Plug("MarcWeber/vim-addon-mw-utils") -- wtf?
--Plug("tomtom/tlib_vim") --wtf2?
vim.call("plug#end")

