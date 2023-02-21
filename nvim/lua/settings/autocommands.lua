vim.cmd('let g:vimtex_view_general_viewer = "evince"')
vim.cmd('let g:vimtex_compiler_method = "latexmk"')

-- colorscheme
local options = {
  transparent = false,
}
local palettes = {
  nightfox = {
    bg1 = "#1A1B27",
  },
}
require("nightfox").setup({
  palettes = palettes,
  options = options,
})
vim.cmd("colorscheme nightfox")

vim.cmd([[highlight TabLineSel guifg=#192330 guibg=#192330]])
vim.cmd([[highlight BufferCurrent guifg=#FFFFFF guibg=#192330]])
vim.cmd([[highlight BufferCurrentIndex guifg=#FFFFFF guibg=#192330]])
vim.cmd([[highlight BufferCurrentMod guifg=#dbc074 guibg=#192330]])
vim.cmd([[highlight BufferCurrentSign guifg=#719cd6 guibg=#192330]])
vim.cmd([[highlight BufferCurrentTarget guifg=#c94f6d guibg=#192330]])
vim.cmd([[highlight BufferInactive guifg=#888888 guibg=#131a24]])
vim.cmd([[highlight BufferInactiveMod guifg=#dbc074 guibg=#131a24]])
vim.cmd([[highlight BufferInactiveSign guifg=#719cd6 guibg=#131a24]])

vim.cmd([[highlight LspInlayHint guibg=#192330]])
vim.cmd(":syntax off")
vim.cmd([[highlight CursorLine guibg=#1A1B27]])
vim.cmd([[highlight CursorLineSign guibg=#1A1B27]])
vim.cmd([[highlight CursorLineFold guibg=#1A1B27]])

