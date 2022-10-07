local Plug = vim.fn['plug#']
vim.call('plug#begin' ,'~/.config/nvim/plugged')
Plug('folke/twilight.nvim')
Plug('nvim-lua/popup.nvim') -- An implementation of the Popup API from vim in Neovim
Plug('nvim-lua/plenary.nvim') -- Useful lua functions used ny lots of plugins
Plug('EdenEast/nightfox.nvim')
Plug('kyazdani42/nvim-web-devicons')
Plug('feline-nvim/feline.nvim')
Plug('lewis6991/gitsigns.nvim')
Plug('tanvirtin/vgit.nvim')
Plug('nvim-lua/plenary.nvim')
Plug('b3nj5m1n/kommentary')
Plug('antoinemadec/FixCursorHold.nvim')
Plug('lambdalisue/fern.vim')
Plug('neovim/nvim-lspconfig')
Plug('nvim-treesitter/nvim-treesitter', {['do']= vim.fn[':TSUpdate']})
Plug('williamboman/nvim-lsp-installer')
Plug('hrsh7th/nvim-cmp')
Plug('hrsh7th/cmp-nvim-lsp')
Plug('hrsh7th/cmp-buffer')
Plug('hrsh7th/cmp-path')
Plug('hrsh7th/cmp-cmdline')
Plug('saadparwaiz1/cmp_luasnip')
Plug('L3MON4D3/LuaSnip')
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'garbas/vim-snipmate'
Plug('kyazdani42/nvim-tree.lua')
Plug('windwp/nvim-autopairs')
Plug('akinsho/bufferline.nvim')
Plug('numToStr/Comment.nvim')
Plug('lukas-reineke/indent-blankline.nvim')
Plug('lewis6991/impatient.nvim')
Plug('lewis6991/spellsitter.nvim')
Plug('moll/vim-bbye')
Plug('nvim-telescope/telescope.nvim')
Plug('ahmedkhalf/project.nvim')
Plug('goolord/alpha-nvim')
Plug('lervag/vimtex')
Plug('weilbith/nvim-code-action-menu')
Plug('mfussenegger/nvim-lint')
Plug 'jose-elias-alvarez/null-ls.nvim'
Plug 'MunifTanjim/prettier.nvim'
Plug 'rafamadriz/friendly-snippets'
Plug 'p00f/nvim-ts-rainbow'
Plug 'mfussenegger/nvim-dap'
Plug 'rcarriga/nvim-dap-ui'
Plug 'theHamsta/nvim-dap-virtual-text'
Plug 'nvim-telescope/telescope-ui-select.nvim' 
Plug 'nvim-telescope/telescope-file-browser.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'
vim.call('plug#end')

