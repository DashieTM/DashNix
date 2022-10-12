local null_ls = require("null-ls")

require("mason-null-ls").setup({
	ensure_installed = {
		"prettier",
		"clang_format",
		"latexindent",
		"shellharden",
		"sql_formatter",
		"fixjson",
		"autopep8",
		"stylua",
		"rustfmt",
		"stylish-haskell",
	},
})

null_ls.setup({
	on_attach = function(client, bufnr)
		if client.server_capabilities.documentRangeFormattingProvider then
			vim.cmd("xnoremap <silent><buffer> <Leader>f :lua vim.lsp.buf.range_formatting({})<CR>")
		end
	end,
	sources = {
		require("null-ls").builtins.formatting.prettier,
		require("null-ls").builtins.formatting.clang_format,
		require("null-ls").builtins.formatting.latexindent,
		require("null-ls").builtins.formatting.shellharden,
		require("null-ls").builtins.formatting.sql_formatter,
		require("null-ls").builtins.formatting.fixjson,
		require("null-ls").builtins.formatting.autopep8,
		require("null-ls").builtins.formatting.stylua,
		require("null-ls").builtins.formatting.rustfmt,
		require("null-ls").builtins.formatting.stylish_haskell,
	},
})
