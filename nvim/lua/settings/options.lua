local options = {
	clipboard = "unnamedplus",
	mouse = "a",
	fileencoding = "utf-8",
	relativenumber = true,
	smartindent = true,
	smartcase = true,
	showmode = true,
	termguicolors = true,
	winbar = "",
	ignorecase = true,
	showtabline = 2,
	timeoutlen = 100,                        -- time to wait for a mapped sequence to complete (in milliseconds)
  undofile = true,                         -- enable persistent undoi      updatetime = 300,                        -- faster completion (4000ms default)
  writebackup = false,                     -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
  expandtab = true,                        -- convert tabs to spaces
  shiftwidth = 2,                          -- the number of spaces inserted for each indentation
  tabstop = 2,                             -- insert 2 spaces for a tab
  cursorline = true,
	scrolloff = 8,                           -- is one of my fav
  sidescrolloff = 8,
  spell = true,
  spelllang = "en_us",
  mousemodel = "popup_setpos",
}

--vim.opt.shortmess:append "c"

for k, v in pairs(options) do
	vim.opt[k] = v
end


