local opts = { noremap = true, silent = true }
local term_opts = { silent = true }
local keymap = vim.api.nvim_set_keymap

-- debug
keymap("n", "<F5>", ':lua require("dap").toggle_breakpoint()<CR>', opts)
keymap("n", "<F6>", ':lua require("dap").step_over()<CR>', opts)
keymap("n", "<F7>", ':lua require("dap").step_into()<CR>', opts)
keymap("n", "<F8>", ':lua require("dapui").toggle()<CR> :lua require("dap").continue()<CR> ', opts)
keymap("n", "<F9>", ':lua require("dap").continue()<CR>', opts)
keymap("n", "<F10>", ':lua require("dap").close()<CR> :lua require("dapui").toggle()<CR>', opts)

-- file tree
keymap("n", "t", ":ToggleTerm<CR>", opts)
keymap("n", "f", ':lua require("nvim-tree").toggle()<CR>', opts)

-- tab switching
keymap("n", "<F1>", ":BufferPrev<CR>", opts)
keymap("n", "<F2>", ":BufferNext<CR>", opts)

-- formatting
keymap("n", "<F4>", ":lua vim.lsp.buf.format { async = true }<CR>", opts)
keymap("n", "<leader>a", ":Telescope lsp_definitions<CR>", opts)
keymap("n", "<leader>s", ":Telescope lsp_references<CR>", opts)
keymap("n", "<leader>d", ":Telescope lsp_type_definitions<CR>", opts)
keymap("n", "<leader>f", ":Telescope lsp_implementations<CR>", opts)
keymap("n", "<leader>q", ":lua vim.lsp.buf.code_action()<CR>", opts)
keymap("n", "<leader>w", ":lua vim.lsp.buf.signature_help()<CR>", opts)
keymap("n", "<leader>e", ":lua vim.lsp.buf.hover()<CR>", opts)
keymap("n", "<leader>r", ":lua vim.lsp.buf.rename()<CR>", opts)
keymap("n", "<leader>gq", ":lua require('telescope.builtin').git_commits()<CR>", opts)
keymap("n", "<leader>gw", ":lua require('telescope.builtin').git_bcommits()<CR>", opts)
keymap("n", "<leader>ge", ":lua require('telescope.builtin').git_branches()<CR>", opts)
keymap("n", "<leader>gr", ":lua require('telescope.builtin').git_status()<CR>", opts)
keymap("n", "<leader>ga", ":lua require('telescope.builtin').git_stash()<CR>", opts)


-- harpoon man

keymap("n", "<C-1>", ":lua require('harpoon.ui').nav_file(1)<CR>", opts)
keymap("n", "<C-2>", ":lua require('harpoon.ui').nav_file(2)<CR>", opts)
keymap("n", "<C-3>", ":lua require('harpoon.ui').nav_file(3)<CR>", opts)
keymap("n", "fma", ":lua require('harpoon.mark').add_file()<CR>", opts)
keymap("n", "fmd", ":lua require('harpoon.mark').remove_file()<CR>", opts)


-- telescope
keymap("n", "fb", ":Telescope file_browser<CR>", {})
keymap("n", "fc", ":Cheatsheet<CR>", {})
keymap("n", "ff", ":lua require('telescope.builtin').find_files()<CR>", {})
keymap("n", "fg", ":lua require('telescope.builtin').live_grep()<CR>", {})
keymap("n", "fh", ":lua require('telescope.builtin').help_tags()<CR>", {})
keymap("n", "fp", ":lua require'telescope'.extensions.project.project{}<CR>", { noremap = true, silent = true })
keymap("n", "fm", ":Telescope harpoon marks<CR>", { noremap = true, silent = true })

vim.keymap.set("n", "<leader>z", ":lua require('telescope').extensions.zoxide.list{}<CR>")

-- trouble
keymap("n", "<C-f>", "<cmd>TroubleToggle<CR>", term_opts)
require("trouble").setup({
  action_keys = {
    --remove the fucking stupid keymap amk
    open_tab = {},
  },
})
