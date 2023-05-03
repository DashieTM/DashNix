local Util = require("lazyvim.util")

local function map(mode, lhs, rhs, opts)
  local keys = require("lazy.core.handler").handlers.keys
  ---@cast keys LazyKeysHandler
  -- do not create the map if a lazy keys handler exists
  if not keys.active[keys.parse({ lhs, mode = mode }).id] then
    opts = opts or {}
    opts.silent = opts.silent ~= false
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end
local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

-- crimes against humanity, but I don't care
map("n", "j", "h", opts)
map("n", "l", "k", opts)
map("n", "k", "j", opts)
map("n", ";", "l", opts)
map("v", "j", "h", opts)
map("v", "k", "j", opts)
map("v", "l", "k", opts)
map("v", ";", "l", opts)

-- debug
map("n", "<F5>", ':lua require("dap").toggle_breakpoint()<CR>', opts)
map("n", "<F6>", ':lua require("dap").step_over()<CR>', opts)
map("n", "<F7>", ':lua require("dap").step_into()<CR>', opts)
map("n", "<F8>", ':lua require("dapui").toggle()<CR> :lua require("dap").continue()<CR> ', opts)
map("n", "<F9>", ':lua require("dap").continue()<CR>', opts)
map("n", "<F10>", ':lua require("dap").close()<CR> :lua require("dapui").toggle()<CR>', opts)

-- file tree
map("n", "<A-f>", ":lua   require('nvim-tree.api').tree.toggle()<CR>", opts)

-- toggle terminal
map("n", "<C-t>", ":lua require('toggleterm').toggle(1)<CR>", opts)

-- tab switching
map("n", "<F1>", ":BufferLineCyclePrev<CR>", opts)
map("n", "<F2>", ":BufferLineCycleNext<CR>", opts)

-- formatting
map("n", "<F4>", ":lua vim.lsp.buf.format { async = true }<CR>", opts)
map("n", "<leader>a", ":Telescope lsp_definitions<CR>", opts)
map("n", "<leader>s", ":Telescope lsp_references<CR>", opts)
map("n", "<leader>d", ":Telescope lsp_type_definitions<CR>", opts)
map("n", "<leader>f", ":Telescope lsp_implementations<CR>", opts)
map("n", "<leader>q", ":lua vim.lsp.buf.code_action()<CR>", opts)
map("n", "<leader>w", ":lua vim.lsp.buf.signature_help()<CR>", opts)
map("n", "<leader>e", ":lua vim.lsp.buf.hover()<CR>", opts)
map("n", "<leader>r", ":lua vim.lsp.buf.rename()<CR>", opts)
map("n", "<leader>gq", ":lua require('telescope.builtin').git_commits()<CR>", opts)
map("n", "<leader>gw", ":lua require('telescope.builtin').git_bcommits()<CR>", opts)
map("n", "<leader>ge", ":lua require('telescope.builtin').git_branches()<CR>", opts)
map("n", "<leader>gr", ":lua require('telescope.builtin').git_status()<CR>", opts)
map("n", "<leader>ga", ":lua require('telescope.builtin').git_stash()<CR>", opts)

-- window switching
function _G.set_terminal_maps()
  local opts = { buffer = 0 }
  vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
  vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
  vim.keymap.set("t", "<A-h>", [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set("t", "<A-j>", [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set("n", "<C-t>", ":lua require('toggleterm').toggle(1)<CR>", opts)
  vim.keymap.set("i", "<C-t>", ":lua require('toggleterm').toggle(1)<CR>", opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd("autocmd! TermOpen term://* lua set_terminal_maps()")
map("n", "<A-j>", ":wincmd h<CR>", opts)
map("n", "<A-k>", ":wincmd j<CR>", opts)
map("n", "<A-l>", ":wincmd k<CR>", opts)
map("n", "<A-;>", ":wincmd l<CR>", opts)

-- harpoon man
map("n", "<C-1>", ":lua require('harpoon.ui').nav_file(1)<CR>", opts)
map("n", "<C-2>", ":lua require('harpoon.ui').nav_file(2)<CR>", opts)
map("n", "<C-3>", ":lua require('harpoon.ui').nav_file(3)<CR>", opts)
map("n", "fma", ":lua require('harpoon.mark').add_file()<CR>", opts)
map("n", "fmd", ":lua require('harpoon.mark').remove_file()<CR>", opts)

-- telescope
map("n", "fb", ":lua require('telescope').extensions.file_browser.file_browser{}<CR>", {})
map("n", "ff", ":lua require('telescope.builtin').find_files()<CR>", {})
map("n", "fg", ":lua require('telescope.builtin').live_grep()<CR>", {})
map("n", "fh", ":lua require('telescope.builtin').help_tags()<CR>", {})
map("n", "fp", ":lua require'telescope'.extensions.project.project{}<CR>", { noremap = true, silent = true })
map("n", "fm", ":Telescope harpoon marks<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>z", ":lua require('telescope').extensions.zoxide.list{}<CR>")

-- trouble
map("n", "<leader>t", "<cmd>TroubleToggle<CR>", term_opts)

-- better yank
function Better_yank(opts)
  local current_line = unpack(vim.api.nvim_win_get_cursor(0))
  vim.api.nvim_command(current_line .. "," .. (opts.count - (current_line - 1)) .. "y")
end

vim.api.nvim_create_user_command("BetterYank", Better_yank, { count = 1 })
map("n", "<leader>y", ":BetterYank<CR>", term_opts)

-- better delete
function Better_delete(opts)
  local current_line = unpack(vim.api.nvim_win_get_cursor(0))
  vim.api.nvim_command(current_line .. "," .. (opts.count - (current_line - 1)) .. "d")
end

vim.api.nvim_create_user_command("BetterDelete", Better_delete, { count = 1 })
map("n", "<leader>d", ":BetterDelete<CR>", term_opts)

-- neovide zoom
local change_scale_factor = function(delta)
  vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
end
vim.keymap.set("n", "<C-=>", function()
  change_scale_factor(1.25)
end)
vim.keymap.set("n", "<C-->", function()
  change_scale_factor(1 / 1.25)
end)

-- neovide paste
vim.g.neovide_input_use_logo = 1
vim.api.nvim_set_keymap('i', '<C-S-V>', '<ESC>p<CR>I', { noremap = true, silent = true})

-- gitui
map("n", "<leader>gg", function()
  Util.float_term({ "gitui" }, { cwd = Util.get_root() })
end, { desc = "gitui (root dir)" })
map("n", "<leader>gG", function()
  Util.float_term({ "gitui" })
end, { desc = "gitui (cwd)" })
