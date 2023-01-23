vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("settings.plugins")
require("settings.options")
require("settings.cmp")
require("settings.lsp")
require("settings.devicons")
require("settings.treesitter")
require("settings.nvim-tree")
require("settings.pairs")
require("settings.indentline")
require("settings.project")
require("settings.dashboard")
require("settings.rainbow")
require("settings.dap")
require("settings.autocommands")
require("settings.telescope")
require("settings.vimtex")
require("settings.keymaps")
require("settings.barbar")

-- simple plugins that don't make sense to put in a seperate file, would clutter too much
require("gitsigns").setup()
require("feline").setup()
require("impatient").enable_profile()
require('Comment').setup()
require("toggleterm").setup({
  autochdir = true,
})
require('leap').add_default_mappings()
require("nvim-highlight-colors").setup {
	render = 'background', -- or 'foreground' or 'first_column'
	enable_named_colors = true,
	enable_tailwind = true,
}
