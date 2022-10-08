local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap


keymap("n", "c" ,":CodeActionMenu<CR>" , opts)
keymap("n", "<F5>" , ':lua require("dap").toggle_breakpoint()<CR>', opts)
keymap("n", "<F6>" , ':lua require("dap").step_over()<CR>', opts)
keymap("n", "<F7>" , ':lua require("dap").step_into()<CR>', opts)
keymap("n", "<F8>" , ':lua require("dap").continue()<CR>',  opts)
keymap("n", "<F9>" , ':lua require("dap").close()<CR> :lua require("dapui").toggle()<CR>',  opts)
keymap("n", "<F10>" , ':lua require("dap").continue()<CR> :lua require("dapui").toggle()<CR>',  opts)
