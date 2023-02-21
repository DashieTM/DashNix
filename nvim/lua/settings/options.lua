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
	cursorline = true,
}

vim.g.mkdp_browser = '/usr/bin/firefox'
vim.g.mkdp_auto_start = 1

-- space leader
vim.g.mapleader = " "
vim.keymap.set("n", "<Space>", "<Nop>", { silent = true, noremap = false })

for k, v in pairs(options) do
	vim.opt[k] = v
end
