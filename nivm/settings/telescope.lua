local builtin = require('telescope.builtin')
local async = require "plenary.async"
require('telescope').setup{}
require('telescope').load_extension('fzy_native')
vim.keymap.set('n', 'ff', builtin.find_files, {})
vim.keymap.set('n', 'fg', builtin.live_grep, {})
vim.keymap.set('n', 'fb', builtin.buffers, {})
vim.keymap.set('n', 'fh', builtin.help_tags, {})
