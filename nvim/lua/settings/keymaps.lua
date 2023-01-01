local opts = { noremap = true, silent = true }
local term_opts = { silent = true }
local keymap = vim.api.nvim_set_keymap

-- space leader
vim.g.mapleader = " "
keymap("n", "<Space>", "<Nop>", { silent = true, noremap = false })

-- debug
keymap("n", "<F5>", ':lua require("dap").toggle_breakpoint()<CR>', opts)
keymap("n", "<F6>", ':lua require("dap").step_over()<CR>', opts)
keymap("n", "<F7>", ':lua require("dap").step_into()<CR>', opts)
keymap("n", "<F8>", ':lua require("dap").continue()<CR> :lua require("dapui").toggle()<CR>', opts)
keymap("n", "<F9>", ':lua require("dap").continue()<CR>', opts)
keymap("n", "<F10>", ':lua require("dap").close()<CR> :lua require("dapui").toggle()<CR>', opts)

-- file tree
keymap("n", "t", ':lua require("nvim-tree").toggle()<CR>', opts)
keymap("n", "f", ':lua require("nvim-tree").focus()<CR>', opts)

-- tab switching
keymap("n", "<F1>", ":BufferPrev<CR>", opts)
keymap("n", "<F2>", ":BufferNext<CR>", opts)

-- formatting
keymap("n", "<F4>", ":lua vim.lsp.buf.format { async = true }<CR>", opts)

-- telescope
keymap("n", "ff", ':lua require("telescope.builtin").find_files()<CR>', {})
keymap("n", "fg", ':lua require("telescope.builtin").live_grep()<CR>', {})
keymap("n", "fb", ':lua require("telescope.builtin").buffers()<CR>', {})
keymap("n", "fh", ':lua require("telescope.builtin").help_tags()<CR>', {})

-- trouble 
keymap("n", "<C-f>", "<cmd>TroubleToggle<CR>", term_opts)
require("trouble").setup {
  action_keys = {
    --remove the fucking stupid keymap amk
    open_tab = {}
  }
}

-- LSP
local on_attach = function(client, bufnr)
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
	local opts = { noremap = true, silent = true, buffer=bufnr }
	keymap("n", "<leader>h", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	keymap("n", "<leader>j", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
	keymap("n", "<leader>k", "<Cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	keymap("n", "<leader>l", "<Cmd>lua vim.lsp.buf.references()<CR>", opts)
	keymap("n", "<leader>;", "<Cmd>lua vim.lsp.buf.code_action()<CR>", opts)
	keymap("n", "<leader>u", "<Cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
	keymap("n", "<leader>g", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
end
