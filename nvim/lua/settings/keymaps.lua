local opts = { noremap = true, silent = true }
local term_opts = { silent = true }
local keymap = vim.api.nvim_set_keymap

-- debug
keymap("n", "<F5>", ':lua require("dap").toggle_breakpoint()<CR>', opts)
keymap("n", "<F6>", ':lua require("dap").step_over()<CR>', opts)
keymap("n", "<F7>", ':lua require("dap").step_into()<CR>', opts)
keymap("n", "<F8>", ':lua require("dap").continue()<CR> :lua require("dapui").toggle()<CR>', opts)
keymap("n", "<F9>", ':lua require("dap").continue()<CR>', opts)
keymap("n", "<F10>", ':lua require("dap").close()<CR> :lua require("dapui").toggle()<CR>', opts)

-- file tree
keymap("n", "t", ":ToggleTerm<CR>", opts)
keymap("n", "n", ':lua require("nvim-tree").toggle()<CR>', opts)

-- tab switching
keymap("n", "<F1>", ":BufferPrev<CR>", opts)
keymap("n", "<F2>", ":BufferNext<CR>", opts)

-- formatting
keymap("n", "<F4>", ":lua vim.lsp.buf.format { async = true }<CR>", opts)
keymap("n", "<leader>q", ":Telescope lsp_definitions<CR>", opts)
keymap("n", "<leader>w", ":Telescope lsp_references<CR>", opts)
keymap("n", "<leader>e", ":Telescope lsp_type_definitions<CR>", opts)
keymap("n", "<leader>a", ":lua vim.lsp.buf.code_action()<CR>", opts)
keymap("n", "<leader>s", ":lua vim.lsp.buf.signature_help()<CR>", opts)

-- telescope
keymap("n", "fb", ":Telescope file_browser<CR>", {})
keymap("n", "fc", ":Cheatsheet<CR>", {})
keymap("n", "ff", ":lua require('telescope.builtin').find_files()<CR>", {})
keymap("n", "fg", ":lua require('telescope.builtin').live_grep()<CR>", {})
keymap("n", "fh", ":lua require('telescope.builtin').help_tags()<CR>", {})
keymap("n", "fp", ":lua require'telescope'.extensions.project.project{}<CR>", { noremap = true, silent = true })

vim.keymap.set("n", "<leader>z", ":lua require('telescope').extensions.zoxide.list{}<CR>")

-- trouble
keymap("n", "<C-f>", "<cmd>TroubleToggle<CR>", term_opts)
require("trouble").setup({
	action_keys = {
		--remove the fucking stupid keymap amk
		open_tab = {},
	},
})

