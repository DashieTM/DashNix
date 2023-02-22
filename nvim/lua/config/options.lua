-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
local options = {
  clipboard = "unnamedplus",
  mouse = "n",
  fileencoding = "utf-8",
  number = true,
  showmode = true,
  termguicolors = true,
  spelllang = "en_us",
  shell = "/usr/bin/zsh",
  autochdir = true,
}

vim.g.mkdp_browser = "/usr/bin/firefox"
vim.g.mkdp_auto_start = 1
for k, v in pairs(options) do
  vim.opt[k] = v
end
