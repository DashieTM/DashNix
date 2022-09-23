--vim.cmd('let g:vimtex_view_method = "zathura"')

vim.cmd('let g:vimtex_view_general_viewer = "evince"')
--let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'

vim.cmd('let g:vimtex_compiler_latexmk = { "options" : [ "-shell-escape", "-interaction=nonstopmode" , "-synctex=1" ], }')

vim.cmd('let g:vimtex_compiler_method = "latexmk"')

vim.cmd('let b:tex_use_shell_escape = 1')

--let maplocalleader = ","


--let g:vimtex_compiler_latexmk = {
--    \ 'options' : [
--    \   '-pdf',
--    \   '-shell-escape',
--    \   '-verbose',
--    \   '-file-line-error',
--    \   '-synctex=1',
--    \   '-interaction=nonstopmode',
--    \ ],
--    \}
