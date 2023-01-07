vim.cmd("let g:vimtex_quickfix_mode=0")
vim.cmd("let g:vimtex_view_general_viewer = 'evince'")
vim.cmd("let g:vimtex_compiler_method = 'latexmk'")
vim.cmd("let g:vimtex_compiler_latexmk = {'options': ['-pdf', '-shell-escape', '-file-line-error', '-synctex=1', '-interaction=nonstopmode',],}")
