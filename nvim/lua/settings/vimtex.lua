vim.cmd("let g:vimtex_quickfix_mode=0")
vim.cmd("let g:vimtex_view_general_viewer = 'evince'")
vim.cmd("let g:vimtex_compiler_method = 'latexmk'")
vim.cmd("let g:vimtex_compiler_latexmk = {'options': ['-pdf', '-shell-escape', '-file-line-error', '--extra-mem-bot=10000000', '-synctex=1', '-interaction=nonstopmode',],}")
